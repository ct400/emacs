;; ---
;; title:    "Simplified emacs init (again)"
;; author:   salopst
;; date:     2022-10-21T11:47:05
;; lastmod:  2022-12-05T09:20:35
;; filename: ~/.config/emacs/init.el
;; filetags: [emacs editor config]
;; refs: 
;;   - https://github.com/bbatsov/emacs.d/blob/master/init.el
;;   - https://github.com/tonyaldon/emacs.d/blob/master/init.el
;; TODO:
;;   - make more simple
;; ---

;;; here be dragons
(server-start)
(add-to-list 'load-path "~/.config/emacs/org-protocol/")
(require 'org-protocol)

(setq initial-scratch-message ";;  SCRATCH! Ah-ha!\n;; Buffer of the Universe\n;; (~/.config/emacs/init.el) \n\n\n")

(set-frame-parameter (selected-frame) 'alpha-background 0.92)  ;; new in Emacs 29

(setq split-window-horizontally -1)

;;;;;;;;;;;;;;;;; PATHS ;;;;;;;;;;;;;;;;;
;;
;;
;; (setq user-emacs-directory "~/.config/emacs")

(add-to-list 'load-path (expand-file-name "sjy2-lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "git-cloned-lisp" user-emacs-directory))
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; after `cp  /usr/share/emacs/site-lisp/mu4e/* ~/.config/emacs/mu4e/`
(add-to-list 'load-path (expand-file-name "mu4e" user-emacs-directory))
;; local themes
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes")
(add-to-list 'custom-theme-load-path "~/.config/emacs/themes/gruvbox")

;; No custom-set-variables in init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq undo-undtree-history-directory-alist '("~/.config/emacs/tmp/undo-tree"))
(setq desktop-save-path '("~/.config/emacs/tmp"))    ;; path to desktop saves
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
  auto-save-file-name-transforms 
  `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;;
;;
;;;;;;;;;;;;;;;;; END PATHS ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; PACKAGE MANAGEMENT ;;;;;;;;;;;;;;;;;
;;
;;
;;; straight is in early-init.el

;;; use-package
(require 'package)
(setq package-archives '(("elpa"   . "https://elpa.gnu.org/packages/")
                         ("melpa"  . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("org"    . "https://orgmode.org/elpa/")))

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))
(setq use-package-verbose t
      comp-async-report-warnings-errors nil
      comp-deferred-compilation t)
(require 'use-package)
(setq use-package-always-ensure t)
;;
;;
;;;;;;;;;;;;;;;;; END PACKAGE MANAGEMENT ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; KEYBINDS ;;;;;;;;;;;;;;;;;
;;
;;
(load-file "~/.config/emacs/sjy2-lisp/sjy2-keybinds.el")

;; replace buffer-menu with ibuffer
 (global-set-key (kbd "C-x C-b") #'ibuffer)

;; Start proced in a similar manner to dired
(global-set-key (kbd "C-x p") #'proced)

;; align code in a pretty way
(global-set-key (kbd "C-x \\") #'align-regexp)
;;
;;
;;;;;;;;;;;;;;;;; END KEYBINDS ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; SANE SETTINGS ;;;;;;;;;;;;;;;;;
;;
;;

;;(toggle-frame-maximized)            ;; ENHANCE!!
(pixel-scroll-precision-mode)       ;; new in 29.x smooth scrolling
(setq load-prefer-newer t)          ;; load newest byte code
(setq enable-local-variables :safe) ;; YOLO

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
;; Keep scrollbar...
;; Why does the U.S. Navy use analog gauges in their reactor plants?
;; It's too easy to glance at a digital gauge and misread it.
(scroll-bar-mode               1)    ;; keep the scroll bar
(tooltip-mode                 -1)    ;; disable tips on menu items
(save-place-mode               1)    ;; remember where point last was
(global-auto-revert-mode       1)    ;; auto-update when on-disk-change
(global-hl-line-mode           1)    ;; Highlight line at point.
(visual-line-mode              t)    ;; Treat each display line as if
(column-number-mode            1)    ;; columns and rows in mode line
(line-number-mode              1)
(delete-selection-mode         1)    ;; typing replaces active selection
(savehist-mode                 1)    ;; remember last minibuffer commands
(fido-vertical-mode           -1)    ;; TODO: vertico?
(winner-mode                   1)    ;; undo/redo windows config
(desktop-save-mode             1)    ;; remember last opened files
(desktop-read)  
(setq use-short-answers        1)    ;; as of Emacs 28.1
(setq visible-bell             1)    ;; DANGER WILL ROBINSON! (Audible if nil)
(setq calendar-style        'iso)    ;; 8601 Gang!
(setq calendar-week-start-day  1)        ;; Week starts Mon (default=0, Sun)
(setq warning-minimum-level :emergency)  ;; ignore warns like docstring length
(setq ad-redefinition-action 'accept  )  ;; ignore def advice warns

;; replace bell with mode-line "nudge"
(setq ring-bell-function
  (lambda ()
    (let ((orig-fg (face-foreground 'mode-line)))
      (set-face-foreground 'mode-line "#F15952")
      (run-with-idle-timer 0.1 nil
        (lambda (fg) (set-face-foreground 'mode-line fg))
        orig-fg))))

(setq-default display-line-numbers-type  'absolute)  ;; relative nonsense without evil    
(global-display-line-numbers-mode                 )  ;; Show line numbers

;; Recent Files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(run-at-time nil (* 5 60) 'recentf-save-list)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; Remeber Shit
;; (use-package command-log-mode
;;   ;; :straight t
;;   ;; (:type built-in)
;;   :diminish
;;   (command-log-mode)
;;   :config
;;    (global-command-log-mode)
;;    (setq command-log-mode-window-size 1.5)
;;    (setq command-log-mode-auto-show t))

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))
(global-set-key [remap dabbrev-expand] 'hippie-expand)
;;
;;
;;;;;;;;;;;;;;;;; END SANE SETTINGS ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; NAVIGATION ;;;;;;;;;;;;;;;;;
;;
;;
;; (unless (package-installed-p 'avy)
;;   (package-install 'avy))

(use-package avy
  :ensure t
  :bind (("C-j"     . avy-goto-char-timer) ;; was electic indent
         ;; ("M-g M-w" . avy-goto-word-or-subword-1)
         ;; ("M-g M-c" . avy-goto-char)
         ("M-g M-l" . avy-goto-line)) ;;beware consult binds
  :commands (avy-goto-word--or-subword-1 avy-goto-char avy-goto-char-timer avy-go-to-line))

;; Jump to any open window or frame
(setq avy-all-windows 'all-frames)


;; better window switching?
;; tbh C-x o works pretty well for the most part
;; C-x o x <wind-num> deletes it
(use-package ace-window
  :ensure t
  :custom
  (aw-minibuffer-flag t)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  ;; (global-set-key (kbd "C-x o") 'ace-window)
  ;; (global-set-key [remap other-window] 'ace-window)
  (ace-window-display-mode 1))


;;
;;
;;;;;;;;;;;;;;;;; END NAVIGATION ;;;;;;;;;;;;;;;;;

;; dired and magit
(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-laGh --group-directories-first")))
(use-package dired-single)

(use-package all-the-icons-dired
  :defer
  :hook (dired-mode . all-the-icons-dired-mode))

;; (use-package dired-hide-dotfiles
;;   :defer
;;   :hook (dired-mode . dired-hide-dotfiles-mode)
;;   :config)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; (use-package git-timemachine
;;   :ensure t
;;   :bind (("s-g" . git-timemachine)))

;;;;;;;;;;;;;;;;; COMPLETIONS AND SHIT ;;;;;;;;;;;;;;;;;
;;
;;

;; Marginalia is focused on annotations only.
;; Embark provides actions
;; Consult offers additional useful commands, like an enhanced buffer switcher and various navigation commands.

(use-package orderless
  ;; :straight t
  :ensure t
  :init
  (setq completion-styles '(flex) ;; was orderless
        completion-category-defaults nil
        completion-category-overrides '((file (styles .  (partial-completion)))))
  :custom
  (orderless-matching-styles'
    (orderless-literal
     orderless-initialism
     orderless-regexp
    ;; orderless-flex                       ; Basically fuzzy finding
    ;; orderless-strict-leading-initialism
    ;; orderless-strict-initialism
    ;; orderless-strict-full-initialism
    ;; orderless-without-literal          ; Recommended for dispatches instead
   )))


(use-package vertico
  :ensure t
  :custom
  (setq vertico-cycle         t)  ;; enable cycling 
  (setq vertico-scroll-margin 5)  ;; Different scroll margin
  (setq vertico-count        15)  ;; Show n candidates
  (setq vertico-resize        t)  ;; Grow/shrink Vertico minibuffer

  (defun kb/vertico-quick-embark (&optional arg)
    "Embark on candidate using quick keys."
    (interactive)
    (when (vertico-quick-jump)
      (embark-act arg)))

  (defun fucking-kill-minibuffer()
    "Fucking kill the fucking mini-fucking-buffer"
    (interactive)
    (abort-recursive-edit)
    (minibuffer-keyboard-quit)
    (exit-minibuffer))
  
  :bind (:map vertico-map
        ("\\t"     . vertico-insert)
        ("C-c C-q" . vertico-exit)
  	("C-c C-j"  . vertico-quick-jump)
  	("<ESC>"   . fucking-kill-minibuffer)
  	:map minibuffer-local-map
  	("M-h"     . backward-kill-word))
  :init
  (vertico-mode)
  :config
  ;; https://github.com/minad/vertico/wiki#prefix-current-candidate-with-arrow
  ;; TODO: delete this??
  (advice-add #'vertico--format-candidate :around
              (lambda (orig cand prefix suffix index _start)
                (setq cand (funcall orig cand prefix suffix index _start))
                (concat
                 (if (= vertico--index index)
                     (propertize "»» " 'face 'vertico-current)
                   "  ")
                 cand))))

(use-package savehist
  :init
  (savehist-mode))

;; ;; TBH, I think I prefer orderless
;; (use-package prescient
;;   ;; :custom
;;   ;; ((prescient-save-file (expand-file-name "tmp/prescient-save.el"
;;   :config
;;   (setq prescient-filter-method '(literal regexp fuzzy))
;;   (prescient-sort-length-enable nil) ;; sort only by freq and recency
;;   (prescient-save-file (expand-file-name "tmp/prescient-save.el"))
;;   (prescient-persist-mode 1))


(use-package embark
  :ensure t
 ;; :straight t
  :bind (("C-."   . embark-act)  )       ;; pick some comfortable binding
        ;;  ("C-;"   . embark-dwim)        ;; good alternative: M-.
        ;;  ("C-h B" . embark-bindings)    ;; alt for 'describe-bindings'
        ;;  :map minibuffer-local-map
        ;;  ("C-."   . embark-act))
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Show Embark actions via which-key
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))


(use-package consult
  :ensure t
  :init
  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :bind (
         ;; C-x bindings (ctl-x-map)
         ("C-x M-;" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b"   . consult-buffer)              ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ;; ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; Custom M-# bindings for fast register access
         ("M-#"   . consult-register-load)
         ("M-'"   . consult-register-store)        ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y"      . consult-yank-pop)           ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e"   . consult-compile-error)
         ("M-g c"   . consult-flycheck)
         ("M-g l"   . consult-goto-line)           ;; orig. goto-line -- simple go to line #
         ("M-g o"   . consult-outline)             ;; Alternative: consult-org-heading
         ("M-g m"   . consult-mark)
         ("M-g k"   . consult-global-mark)
         ("M-g i"   . consult-imenu)               ;; go to function decls etc.
         ("M-g I"   . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-g f"   . consult-find)                 ;; search for files
	 ("M-g F"   . consult-locate)               ;; alt search for files
         ("M-g g"   . consult-grep)
         ("M-g G"   . consult-git-grep)
         ("M-g r"   . consult-ripgrep)
         ("M-g M-l" . consult-line)                 ;; fuzy search string, go to line.
         ("M-g L"   . consult-line-multi)           ;; same butx all buffers-- CONFUSING
         ("M-g M"   . consult-multi-occur)
         ("M-G k"   . consult-keep-lines)
         ("M-G u"   . consult-focus-lines)
	 ("C-x r m" . consult-bookmark)
         ;;; Bulk remaps
	 ([remap list-buffers]  . consult-buffer)
         ([remap bookmark-jump] . consult-bookmark)
         ([remap yank-pop]      . consult-yank-pop)
         ([remap keep-lines]    . consult-keep-lines))
  :custom
  (completion-in-region-function #'consult-completion-in-region))

;; ;; https://github.com/karthink/consult-dir
;; (use-package consult-dir                ; Consult based directory picker
;;   :demand :after vertico
;;   :bind
;;   (:map vertico-map
;;         ("M-." . consult-dir)
;;         ("M-j" . consult-dir-jump-file)))


;; ;; Consult users will also want the embark-consult package.
;; (use-package embark-consult
;;   :ensure t
;;   :after (embark consult)
;;   :demand t ; only necessary if you have the hook below
;;   ;; if you want to have consult previews as you move around an
;;   ;; auto-updating embark collect buffer
;;   :hook
;;   (embark-collect-mode . consult-preview-at-point-mode))


;; (use-package company
;;   :ensure t
;;   :config
;;   (setq company-idle-delay 0.5)
;;   (setq company-show-numbers t)
;;   (setq company-tooltip-limit 10)
;;   (setq company-minimum-prefix-length 2)
;;   (setq company-tooltip-align-annotations t)
;;   ;; invert the navigation direction if the the completion popup-isearch-match
;;   ;; is displayed on top (happens near the bottom of windows)
;;   (setq company-tooltip-flip-when-above t)
;;   (global-company-mode)
;;   (diminish 'company-mode))

;; (use-package hl-todo
;;   :ensure t
;;   :config
;;   (setq hl-todo-highlight-punctuation ":")
;;   (global-hl-todo-mode))


;;
;;
;;;;;;;;;;;;;;;;; END COMPLETIONS AND SHIT ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; THEMES FONTS FACES ;;;;;;;;;;;;;;;;;
;;
;;
;; TODO: doom-one??
;; monotropic, modus themes --- Still looking for a nice light for prose.
;; material theme is a nice dark one if I get bored.
(setq custom-safe-themes t)
;; (load-theme 'discreet t)
;; (load-theme 'gruber-darker t)
(load-theme 'gruber-shrews t)
;; (load-theme 'gruvbox-dark-soft t) ;; no worky
;; (load-theme 'tsdh-light t)
;;  (load-theme 'zenburn t)
;; (set-face-attribute 'region nil :background "#6A5E51" :foreground "#282828") ;; use w/ gruvbox


;;;;; font and faces
;; (set-face-attribute 'default nil :font "Cousine-13")
(set-face-attribute 'default nil :font "Firacode-12")
;; (set-face-attribute 'default nil :font "Hack Nerd Font-12")
;; (set-face-attribute 'default nil :font "Inconsolata-12")
;; (set-face-attribute 'default nil :font "Iosevka Comfy Motion 13")
;; (set-face-attribute 'default nil :font "Iosevka-13")
;; (set-face-attribute 'default nil :font "Menlo-12")

(custom-set-faces 
 '(Info-quoted       ((t (:foreground "#F15952" :family "Hack-13"))))
 '(minibuffer-prompt ((t (:foreground "#4B919E" :family "Menlo-14")))))

;;; PRETIFFY

;; cutsey icons
(use-package all-the-icons
  ;; :straight t
  :if (display-graphic-p))

(use-package all-the-icons-completion
  :after (marginalia all-the-icons)
  :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
  :init
  (all-the-icons-completion-mode))

;; show hex colours
(use-package rainbow-mode
  ;; :straight t
  :diminish
  :init)

;;
;;
;;;;;;;;;;;;;;;;; END THEMES FONTS FACES ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; HELP AND INFO ;;;;;;;;;;;;;;;;;
;;
;;

;; help with incomplete key presses
(use-package which-key
  :ensure t
  :custom
  (which-key-show-transient-maps t)
  :config
  (which-key-mode))

;; inline descriptions from docstrings
(use-package marginalia
  :ensure t
  :custom
  (marginalia-align 'left) ;; left is default
 ;; (marginalia-align-offset 5)
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :config
  (marginalia-mode))

;; prettier doc pages
(use-package helpful
  :ensure t)
;; Note that the built-in `describe-function' includes both functions
;; and macros. `helpful-function' is functions only, so we provide
;; `helpful-callable' as a drop-in replacement.
(global-set-key (kbd "C-h f")   #'helpful-callable)
(global-set-key (kbd "C-h v")   #'helpful-variable)
(global-set-key (kbd "C-h k")   #'helpful-key)
(global-set-key (kbd "C-h o")   #'helpful-symbol)
(global-set-key (kbd "C-h p")   #'helpful-at-point)
(global-set-key (kbd "C-c C-d") #'helpful-at-point)
;;
;;
;;;;;;;;;;;;;;;;; END HELP AND INFO ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; EDITING CONVENIENCES ;;;;;;;;;;;;;;;;;
;;
;;
;; I am a savage, not using rectangular actions and, ofc, macros
(use-package multiple-cursors
  :ensure t)

;; Do What I Mean. Both marked an unmarked regions
(global-set-key (kbd "C-M-j")       'mc/mark-all-dw)
(global-set-key (kbd "C-M-.")       'mc/mark-next-like-this) ;; THIS IS KEY !!
(global-set-key (kbd "S-M-<down>")  'mc/mark-next-like-this) ;; VSCode
(global-set-key (kbd "C-M-,")       'mc/mark-previous-like-this)
(global-set-key (kbd "S-M-<up>")    'mc/mark-previous-like-this) ;; VSCode
(global-set-key (kbd "C-M-/")       'mc/mark-all-like-this)


(require 'emacs-surround)
;; delete with C-q d <whatever>
;; switch with C-q i <orig> <new>
;; TODO: check https://github.com/rejeep/wrap-region.el
(add-to-list 'emacs-surround-alist '("=" . ("=" . "=")))
(add-to-list 'emacs-surround-alist '("*" . ("*" . "*")))
(add-to-list 'emacs-surround-alist '("~" . ("~" . "~")))
(add-to-list 'emacs-surround-alist '("**" . ("**" . "**")))
(add-to-list 'emacs-surround-alist '("+" . ("+" . "+")))
(add-to-list 'emacs-surround-alist '("_" . ("_" . "_")))
(add-to-list 'emacs-surround-alist '("/" . ("/" . "/")))
;; YASnippet better for this
(add-to-list 'emacs-surround-alist '("c" . ("```\n" . "\n```")))

(global-set-key (kbd "C-q") 'emacs-surround)

;; better undo?
(use-package undo-tree
  ;; C-x u == visualise undo-tree-visualize
  ;; C-p/n == up/down tree; d == diff; t == timestamps; q == quit
  :ensure t
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-auto-save-history t)
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo-tree")))
  (undo-tree-visualizer-timestamps t))

(use-package default-text-scale
  ;; C+M+- and C+M+=
  :defer 1
  :config
  (default-text-scale-mode))

(use-package yasnippet
  ;; :straight t
  ;; (:type git)
  :ensure t
  :hook ((text-mode
          prog-mode
          conf-mode
          snippet-mode) . yas-minor-mode-on)
  :config
  (setq yas-snippet-dir "~/.config/emacs/yasnippets")
  ;; (setq yas-snippet-dirs 
  ;;   '("~/.config/emacs/yasnippets" 
  ;;     "~/Dropbox/emacs-yasnippets"))
  (yas-global-mode 1))    ;; or M-x yas-reload-all

;;
;;
;;;;;;;;;;;;;;;;;  END EDITING CONVENIENCES ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;  LANGS ;;;;;;;;;;;;;;;;;
;;
;;

;;; parens
 (use-package smartparens
  :config
  (smartparens-global-mode -1))
  ;;:hook (prog-mode . smartparens-mode))

(use-package yaml-mode
  :ensure t)

(use-package markdown-mode
  ;; :straight t
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\.markdown\\'" . gfm-mode))
  :init (setq markdown-command "pandoc")
  ;; :init (setq markdown-command "multimarkdown"))
  (setq markdown-fontify-code-blocks-natively t)
    (add-hook 'markdown-mode-hook
      (lambda ()
        (when buffer-file-name
          (add-hook 'after-save-hook 'check-parens nil t)))))

;;; LaTeX support
(unless (package-installed-p 'auctex)
  (package-install 'auctex))
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;; Enable LaTeX math support
(add-hook 'LaTeX-mode-map #'LaTeX-math-mode)

;; Enable reference mangment
(add-hook 'LaTeX-mode-map #'reftex-mode)


;;;;;; tree-sitter Emacs-29
;; https://git.savannah.gnu.org/cgit/emacs.git/tree/admin/notes/tree-sitter/starter-guide?h=feature/tree-sitter

(use-package tree-sitter
  :ensure t
  :config
  ;; activate tree-sitter on any buffer containing code for which it has a parser available
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :ensure t
  :after tree-sitter)
;; auto-format different source code files extremely intelligently;; https://github.com/radian-software/apheleia;; (use-package apheleia;;   :ensure t;;   :config;;   (apheleia-global-mode -1))

;; Enabled inline static analysis
(add-hook 'prog-mode-hook #'flymake-mode)

;;; Pop-up completion
(unless (package-installed-p 'corfu)
  (package-install 'corfu))

;; Enable autocompletion by default in programming buffers
(add-hook 'prog-mode-hook #'corfu-mode)

;;;;; LSP
;; not necessary-- built into Emacs-29
(use-package eglot
:ensure t)

;; npm install -g bash-language-server@4.0.0-beta.3
(add-hook 'bash-mode-hook 'eglot-ensure)

;;sudo apt-get install clangd-12
(add-hook 'c-mode-hook 'eglot-ensure)

;; go install golang.org/x/tools/gopls@latest
(add-hook 'go-mode-hook #'eglot-ensure)

;; TODO: check this PY setup: https://gist.github.com/Nathan-Furnal/b327f14e861f009c014af36c1790ec49F
;; 
(setq python-shell-interpreter "python3")
(add-hook 'python-mode-hook 'eglot-ensure)


(use-package python
  :config
  ;; Remove guess indent python message
  (setq python-indent-guess-indent-offset-verbose nil))

;; <OPTIONAL> Buffer formatting on save using black.
;; See: https://github.com/pythonic-emacs/blacken.
(use-package blacken
  :ensure t
  :defer t
  :custom
  (blacken-allow-py36 t)
  (blacken-skip-string-normalization t)
  :hook (python-mode-hook . blacken-mode))

;; gem install solargraph
(add-hook 'ruby-mode-hook 'eglot-ensure)

;;; Inline static analysis
(add-hook 'prog-mode-hook #'flymake-mode)


;;
;;
;;;;;;;;;;;;;;;;;  END LANGS ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; RANDO AND CUSTOM CODE ;;;;;;;;;;;;;;;;;
;;
;;

;;; movey liney
(defmacro ew/save-column (&rest body)
  `(let ((column (current-column)))
     (unwind-protect
         (progn ,@body)
       (move-to-column column))))
(put 'ew/save-column 'lisp-indent-function 0)

(defun ew/move-line-up ()
  "move line up. Bound to M-<up> like VSCode"
  (interactive)
  (ew/save-column
    (transpose-lines 1)
    (forward-line -2)))
(global-set-key (kbd "M-<up>")      'ew/move-line-up)

(defun ew/move-line-down ()
  "move line down. Bound to M-<down> like VSCode"
  (interactive)
  (ew/save-column
    (forward-line 1)
    (transpose-lines 1)
    (forward-line -1)))
(global-set-key (kbd "M-<down>")    'ew/move-line-down)
;;; END movey liney

;; ;; works but, no newline
;; ;; emacs-surround also allows deletion/switching
;; (defun ew/surround (begin end open close)
;;   "Put OPEN at START and CLOSE at END of the region.
;; If you omit CLOSE, it will reuse OPEN."
;;   (interactive  "r\nsStart: \nsEnd: ")
;;   (when (string= close "")
;;     (setq close open))
;;   (save-excursion
;;     (goto-char end)
;;     (insert close)
;;     (goto-char begin)
;;     (insert open)))

(defun ew/toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
	     (next-win-buffer (window-buffer (next-window)))
	     (this-win-edges (window-edges (selected-window)))
	     (next-win-edges (window-edges (next-window)))
	     (this-win-2nd (not (and (<= (car this-win-edges)
					 (car next-win-edges))
				     (<= (cadr this-win-edges)
					 (cadr next-win-edges)))))
	     (splitter
	      (if (= (car this-win-edges)
		     (car (window-edges (next-window))))
		  'split-window-horizontally
		'split-window-vertically)))
	(delete-other-windows)
	(let ((first-win (selected-window)))
	  (funcall splitter)
	  (if this-win-2nd (other-window 1))
	  (set-window-buffer (selected-window) this-win-buffer)
	  (set-window-buffer (next-window) next-win-buffer)
	  (select-window first-win)
	  (if this-win-2nd (other-window 1))))))

(define-key ctl-x-5-map "t" 'ew/toggle-window-split)

(defun sjy2/kill-all ()
  (interactive)
  (delete-other-windows)
  (abort-minibuffers)
  (keyboard-quit))

(defun sjy2/log-diary()
  (interactive)
  (setq filename (concat "~/_scratch/" (format-time-string "%Y-%m-%dT%H.%M") ".md"))
  (find-file filename)
  (insert (concat "---\ntitle =\" \" "\nauthor = (getenv "USER)" "\ndate = (format-time-string "%Y-%m-%dT%H.%M")" "\n---"))))

;; <https://emacsredux.com/blog/2013/05/22/smarter-navigation-to-the-beginning-of-a-line/>
;; Actually there is M-m for back-to-indentation
(defun rde-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (- arg 1))))

  (let ((orig-point (point)))
    (move-beginning-of-line 1)
    (when (= orig-point (point))
      (back-to-indentation))))

(define-key global-map
  [remap move-beginning-of-line]
  'rde-move-beginning-of-line)


;;;;;;;;;;;;;;;;; ORGMODE ;;;;;;;;;;;;;;;;;
;;
;;
;;; paths
(setq org-directory (expand-file-name "~/_scratch/org"))
(setq org-roam-directory "~/_scratch/org/roam")
(setq org-default-notes-file (concat org-directory "~/_scratch/scratch.org"))
(setq org-startup-indented t)
(setq org-startup-folded (quote overview))

;;; keybinds
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;;; sane defaults
(setq org-hide-emphasis-markers nil
      org-special-ctrl-a/e t
      org-special-ctrl-k t
      org-src-fontify-natively t
      org-fontify-whole-heading-line t
      org-fontify-quote-and-verse-blocks t
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 2
      org-hide-block-startup nil
      org-src-preserve-indentation nil
      org-startup-folded 'content
      org-cycle-separator-lines 2)

;; show images by default
(setq-default org-display-inline-images t)
(setq-default org-startup-with-inline-images t)
(setq-default org-display-remote-inline-images t)

(setq org-ctrl-k-protect-subtree t)   ;; DANGER aversion
(setq org-ellipsis "⤵")
(setq org-export-with-smart-quotes t) ;; typographical quotes
;; Also need =#+LATEX_HEADER: \usepackage{listings}= in the LaTeX SETUPFILE,
(setq org-latex-listings 't)
(setq org-log-done t)              ;; 

;;; pretty bullets
(use-package org-bullets 
    :config
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

;; (defcustom org-bullets-bullet-list
;;   '(;;; Large
;;     "◉"
;;     "○"
;;     "✸"
;;     "✿"
;;     ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
;;     ;;; Small
;;     ;; ► • ★ ▸
;;     )
;;   "This variable contains the list of bullets.
;; It can contain any number of symbols, which will be repeated."
;;   :group 'org-bullets
;;   :type '(repeat (string :tag "Bullet character")))

;;; org block templates
(use-package org-tempo
  :ensure nil
  :after org
  :config
  (let ((templates '(("e"   . "example")
                     ("el"  . "src emacs-lisp")
                     ("pl"  . "src perl")
                     ("py"  . "src python")
                     ("q"   . "quote")
                     ("v"   . "verse")
                     ("r"   . "results")
                     ("rb"  . "src ruby")
                     ("sh"  . "src sh"))))
       (dolist (template templates)
          (push template org-structure-template-alist))))

;;; notes for PDFs
(use-package org-noter
  :after (pdf-tools)
  :init
  (setq org-noter-notes-search-path '("~/_scratch/org/")))

;;;; Better PDFs
;;https://github.com/politza/pdf-tools
;; annotate pdfs with c-c c-a
;; hl with c-c c-a h
;; for help M-x pdf-tools-help RET
;; (load (concat user-emacs-directory
;;               "lisp/exwm-config.el"))
(use-package pdf-tools
  :defer t
  :commands (pdf-view-mode pdf-tools-install)
  :mode ("\\.[pP][dD][fF]\\'" . pdf-view-mode)
  :magic ("%PDF" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (define-pdf-cache-function pagelabels)
  (setq-default pdf-view-display-size 'fit-page)
  (add-to-list 'org-file-apps
               '("\\.pdf\\'" . (lambda (file link)
                                 (org-pdfview-open link)))))
;;
;;
;;;;;;;;;;;;;;;;; END ORGMODE ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; MAIL ;;;;;;;;;;;;;;;;;
;;
;;
;;; mu4e
(load (concat user-emacs-directory
              "sjy2-lisp/mu4e-config.el"))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
;;
;;
;;;;;;;;;;;;;;;;; END MAIL ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; SOCIAL AND GOOFING ;;;;;;;;;;;;;;;;;
;;
;;
;;; IRC Client
(setq rcirc-server-alist
      '(("irc.libera.chat" :channels ("#emacs" "#org-mode" "#systemcrafters")
         :port 6697 :encryption tls)))
(setq rcirc-default-nick "centzon")
(setq rcirc-prompt "»» "
      rcirc-time-format "%H:%M "
      rcirc-fill-flag t)
(add-hook 'rcirc-mode-hook #'rcirc-track-minor-mode)
(add-hook 'rcirc-mode-hook #'rcirc-omit-mode)
(add-hook 'rcirc-mode-hook
          (lambda ()
            (set (make-local-variable 'scroll-conservatively) 8192)))

(eval-after-load "rcirc"
  '(progn
     ;; Use blue for my own nick + the prompt
     (set-face-attribute 'rcirc-my-nick nil :foreground "steel blue" :weight 'bold)
     (set-face-attribute 'rcirc-prompt nil :foreground "steel blue")
     ;; Use a bold grey for other nicks
     (set-face-attribute 'rcirc-other-nick nil :foreground "#686868" :weight 'bold)
     ;; Change my nick highlight from bold neon purple to dark red
     (set-face-attribute 'rcirc-nick-in-message-full-line nil :foreground "dark red" :weight 'normal)
     (set-face-attribute 'rcirc-nick-in-message nil :foreground "dark red" :weight 'bold)
     ;; De-emphasise the timestamps + dimmed nicks
     (set-face-attribute 'rcirc-timestamp nil :foreground "#999999")
     (set-face-attribute 'rcirc-dim-nick nil :foreground "#999999")
     ;; Emphasise the brightened nicks
     (set-face-attribute 'rcirc-bright-nick nil :foreground "steel blue" :weight 'bold)
     ;; Use light grey instead of bright red for server messages
     (set-face-attribute 'rcirc-server nil :foreground "#999999")))



;;; Mastodon
(use-package mastodon
  :ensure t
  :config
  (mastodon-discover)
  (setq mastodon-instance-url "https://emacs.ch"
        mastodon-active-user "ct42"))

;;
;;
;;;;;;;;;;;;;;;;; END SOCIAL AND GOOFING ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; XXXX ;;;;;;;;;;;;;;;;;
;;
;;

;; /pʰɪˈlɒsəfi/
;; /fɪˈlɒsəfi/
;; /ɸɪˈlɒsəfi/
;; /fɪʃ/
;;
;;
;;;;;;;;;;;;;;;;; END XXXX ;;;;;;;;;;;;;;;;;


;;; END of init.el
