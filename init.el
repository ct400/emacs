;; -*- mode: emacs-lisp -*-
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
;;   - nhttps://github.com/VernonGrant/emacs-keyboard-shortcuts
;; TODO:
;;   - make more simple
;;   - check this from time to time: yhttps://github.com/jwiegley/use-package-examples
;; ---

(occur "^;+ [0-9]+ ")


;;; here be dragons
(server-start)
(require 'org-protocol)
(add-to-list 'load-path "~/.config/emacs/org-protocol/")


;;;;;;;;;;;;;;;;; 01 PATHS ;;;;;;;;;;;;;;;;;
;;
;;

(setq user-emacs-directory "~/.config/emacs/")
(add-to-list 'load-path (expand-file-name "sjy2-lisp" user-emacs-directory))
;; refresh random web-gotten git with
;; ~/bin/git-refresh.sh
(let ((default-directory  "~/.config/emacs/git-cloned-lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
;; after `sudo cp  /usr/share/emacs/site-lisp/mu4e/* ~/.config/emacs/mu4e/`
(add-to-list 'load-path (expand-file-name "mu4e" user-emacs-directory))
;; local themes
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; No custom-set-variables in init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(setq undo-undtree-history-directory-alist '("~/.config/emacs/tmp/undo-tree/"))
(setq backup-directory-alist '(("." . "~/.config/emacs/tmp/backups/")))
;; (setq backup-directory-alist '((expand-file-name "tmp/backups" user-emacs-directory)))

(setq desktop-save-path '("~/.config/emacs/tmp"))    ;; path to desktop saves
(setq auto-save-list-file-prefix (expand-file-name "tmp/auto-saves/sessions/" user-emacs-directory)
  auto-save-file-name-transforms 
  `((".*" ,(expand-file-name "tmp/auto-saves/" user-emacs-directory) t)))

;;
;;
;;;;;;;;;;;;;;;;; END PATHS ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 02 PACKAGE MANAGEMENT ;;;;;;;;;;;;;;;;;
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


;;;;;;;;;;;;;;;;; 03 KEYBINDS ;;;;;;;;;;;;;;;;;
;;
;;

(load-file "~/.config/emacs/sjy2-lisp/sjy2-keybinds.el")

;; this lets us have long lines go off the side of the screen instead of hosing up the ascii art
(global-set-key "\C-x\C-l"      'toggle-truncate-lines) ;; was downcase-region
(global-set-key (kbd "C-S-R")   'rename-file)
(define-key global-map "\M-Q"   'unfill-paragraph)
(global-set-key (kbd"C-S-z")    'undo-redo)
(global-set-key (kbd "C-x C-b") #'ibuffer)       ;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x p")   #'proced)        ;; Start proced like dired
(global-set-key (kbd "C-x \\")  #'align-regexp)  ;; align code
(global-set-key (kbd "C-c C-d") 'duplicate-dwim) ;; Emacs-29 duplicate line, region whatever
;;(bind-key "\C-c\C-d" "\C-a\C- \C-n\M-w\C-y") ; duplicate whole line
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(global-set-key (kbd "M-r") 'er/expand-region) ;;
(global-set-key (kbd "C-c C-w w") #'ew/resize-window)

;;; faster M-xing
(defalias 'jos 'just-one-space)
(defalias 'job 'delete-blank-lines) ;; C-x C-o in Emacs-q
(defalias 'ur  'unfill-region)
(defalias 'up  'unfill-paragraph)   ;; cf to M-q -- fill-paragraph in Emacs-q
(defalias 'ut  'unfill-toggle)
(defalias 'kc  'keycast-mode-line-mode)
(defalias 'ka  'sjy2/kill-all)
(defalias 'du  'duplicate-dwim)

;;
;;
;;;;;;;;;;;;;;;;; END KEYBINDS ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 04 SANE SETTINGS ;;;;;;;;;;;;;;;;;
;;
;;

(setq initial-scratch-message ";;  SCRATCH! Ah-ha!\n;; Buffer of the Universe\n;; (~/.config/emacs/init.el) \n\n\n")
(set-frame-parameter (selected-frame) 'alpha-background 0.98)  ;; new in Emacs 29
(setq split-window-horizontally 1)
;; (toggle-frame-maximized)            ;; ENHANCE!!
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
(setq column-number-mode       t)    ;; columns and rows in mode line
(line-number-mode              1)
(delete-selection-mode         1)    ;; typing replaces active selection
(savehist-mode                 1)    ;; remember last minibuffer commands
;;(setq savehist-file "~/.config/emacs/history") ;; this is default
(fido-vertical-mode           -1)    ;; TODO: vertico?
(winner-mode                   1)    ;; undo/redo windows config
(desktop-save-mode             1)    ;; remember last opened files
(desktop-read)  
(setq use-short-answers        1)    ;; as of Emacs 28.1
(setq next-line-add-newlines   t)    ;; C-n inserts \n at buffer end.
(setq visible-bell             1)    ;; DANGER WILL ROBINSON! (Audible if nil)
(setq calendar-style        'iso)    ;; 8601 Gang!
(setq create-lockfiles nil      )    ;; No lockfiles
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

;; (setq-default display-line-numbers-type  'absolute)
(setq-default display-line-numbers-type  'relative)
(global-display-line-numbers-mode                 )

;; Recent Files
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(run-at-time nil (* 5 60) 'recentf-save-list)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

(set-register ?j (cons 'file (concat org-directory "jokes.org")))
(set-register ?e (cons 'file (concat org-directory "emacs.org")))

;; hippie expand is dabbrev expand on steroids
;; TODO: get Corfu in on this action?
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

;; Buffers

(add-to-list 'display-buffer-alist
 '("\\*e?shell\\*"
   (display-buffer-in-side-window)
   (side . bottom)
   (slot . -1) ;; -1 == L  0 == Mid 1 == R
   (window-height . 0.33) ;; take 2/3 on bottom left
   (window-parameters
    (no-delete-other-windows . nil))))

(add-to-list 'display-buffer-alist
 '("\\*\\(Backtrace\\|Compile-log\\|Messages\\|Warnings\\)\\*"
   (display-buffer-in-side-window)
   (side . bottom)
   (slot . 0)
   (window-height . 0.33)
   (window-parameters
     (no-delete-other-windows . nil))))

(add-to-list 'display-buffer-alist
 '("\\*\\([Hh]elp\\|Command History\\|command-log\\)\\*"
   (display-buffer-in-side-window)
   (side . right)
   (slot . 0)
   (window-width . 80)
   (window-parameters
     (no-delete-other-windows . nil))))

;;
;;
;;;;;;;;;;;;;;;;; END SANE SETTINGS ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 05 BUFFER PLACEMENT ;;;;;;;;;;;;;;;;;
;;
;;
(add-to-list 'display-buffer-alist
 '("\\*e?shell\\*"
   (display-buffer-in-side-window)
   (side . bottom)
   (slot . -1) ;; -1 == L  0 == Mid 1 == R
   (window-height . 0.33) ;; take 2/3 on bottom left
   (window-parameters
    (no-delete-other-windows . nil))))

(add-to-list 'display-buffer-alist
 '("\\*\\(Backtrace\\|Compile-log\\|Messages\\|Warnings\\)\\*"
   (display-buffer-in-side-window)
   (side . bottom)
   (slot . 0)
   (window-height . 0.33)
   (window-parameters
     (no-delete-other-windows . nil))))

(add-to-list 'display-buffer-alist
 '("\\*\\([Hh]elp\\|Command History\\|command-log\\)\\*"
   (display-buffer-in-side-window)
   (side . right)
   (slot . 0)
   (window-width . 80)
   (window-parameters
     (no-delete-other-windows . nil))))
;;
;;
;;;;;;;;;;;;;;;;; END BUFFER PLACEMENT ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 06 NAVIGATION ;;;;;;;;;;;;;;;;;
;;
;;
;; (use-package evil
;; 	:ensure t
;; 	:config
;; 	(evil-mode)
;; 	(evil-set-undo-system 'undo-tree))


;; https://github.com/mickeynp/smartscan
;; M-n and M-p move between symbols and type M-' to replace all symbols in the buffer matching the one under point, and C-u M-' to replace symbols in your current defun only (as used by narrow-to-defun.)

;; git clone git@github.com:mickeynp/smart-scan.git ~/.config/emacs/git-cloned-lisp/smart-scan
(require 'smartscan)
(smartscan-mode 1)

(use-package avy
  :ensure t
  :bind (("C-j"     . avy-goto-char-timer)) ;; was electic indent
         ;; ("M-g M-w" . avy-goto-word-or-subword-1)
         ;; ("M-g M-c" . avy-goto-char)
         ;; ("M-g M-l" . avy-goto-line) ;; consult takes precedence
  :commands (avy-goto-word--or-subword-1 avy-goto-char avy-goto-char-timer avy-go-to-line))

;; Jump to any open window or frame
(setq avy-all-windows 'all-frames)

;; better window switching?
;; tbh C-x o works fairly well for the most part
;; C-x o x <wind-num> deletes it
(use-package ace-window
  :ensure t
  :custom
  (aw-minibuffer-flag t)
  (aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  ;; (global-set-key (kbd "C-x o") 'ace-window)
  (global-set-key [remap other-window] 'ace-window)
  (ace-window-display-mode 1))

;; TODO: filter groups. 
;; https://blog.modelworks.ch/ibuffer-for-looking-at-your-buffers-in-emacs/
(use-package ibuffer
  :ensure t
  :config
  (setq ibuffer-movement-cycle-true t)
  (setq ibuffer-show-empty-filter-groups nil)
)

;;
;;
;;;;;;;;;;;;;;;;; END NAVIGATION ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 07 DIRED AND MAGIT ;;;;;;;;;;;;;;;;;
;;
;;

(setq dired-listing-switches "-laGh --group-directories-first")
(global-set-key (kbd "C-x C-j") 'dired-jump)
(define-key dired-mode-map (kbd "b")  'dired-up-directory)  ;; mirrors f dired-find-file
(define-key dired-mode-map (kbd "e" ) 'dired-create-empty-file)
(add-hook 'dired-mode-hook 'dired-git-mode)

(use-package all-the-icons-dired
  :defer
  :hook (dired-mode . all-the-icons-dired-mode))

;; ;; no spawn new buffer for new directory visited;
(require 'dired-single) ;; in  $GIT_CLONED_LISP

(use-package dired-narrow
   :ensure t)

(use-package dired-git
  :ensure t
  :hook
  (dired-mode . dired-git-mode))


;;; VERSION CONTROL
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine
   :ensure t
   :bind (("s-g" . git-timemachine)))

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode 1)
  (setq git-gutter:update-interval 0.02))
;;  (global-set-key (kbd "M-<up>") 'git-gutter+-previous-hunk)
;;  (global-set-key (kbd "M-<down>") 'git-gutter+-next-hunk))


;; You can use git-gutter-fringe even if you disable vc-mode. While diff-hl benefits from VC.
(use-package git-gutter-fringe
  :ensure t
  :config
  (define-fringe-bitmap 'git-gutter-fr:added     [140]    nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified  [140]    nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted   [140]    nil nil '(center repeated)))
;; keep with git-gutter-fringe package
  (custom-set-faces
   '(git-gutter-fr:deleted   ((t (:foreground "#F15952" :background "#F15952"))))
   '(git-gutter-fr:modified  ((t (:foreground "#4B919E" :background "#4B919E"))))
   '(git-gutter-fr:added     ((t (:foreground "#87CF70" :background "#87CF70")))))
;;
;;
;;;;;;;;;;;;;;;;; END DIRED AND MAGIT ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 08 COMPLETIONS AND SHIT ;;;;;;;;;;;;;;;;;
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

  (defun sjy2/fucking-kill-minibuffer()
    "Fucking kill the fucking mini-fucking-buffer"
    (interactive)
    (abort-recursive-edit) ;; C-] and C-x X a in Emacs-q
    (minibuffer-keyboard-quit)
    (exit-minibuffer))
  
  :bind (:map vertico-map
        ("\\t"     . vertico-insert)
        ("C-c C-q" . vertico-exit)
  	("C-c C-j" . vertico-quick-jump)
  	("<ESC>"   . sjy2/fucking-kill-minibuffer)
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
                     (propertize "???? " 'face 'vertico-current)
                   "  ")
                 cand))))

;; TODOL delete)-- this is built-in
;; (use-package savehist
;;   :init
;;   (savehist-mode))



(use-package embark
  :ensure t
 ;; :straight t
  :bind (("C-."   . embark-act)
        ("M-."   . embark-dwim))      ;; good alternative: C-;
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
  ;; "orig" ==  overrides Emacs-q defaults, so no biggie
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :bind (
         ;; C-x bindings (ctl-x-map)
         ("C-x M-;" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b"   . consult-buffer)              ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ;; Custom M-# bindings for fast register access TODO:
         ("M-#"   . consult-register-load)
         ("M-'"   . consult-register-store)        ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y"      . consult-yank-pop)           ;; orig. yank-pop
         ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; M-g bindings (goto-map)
         ("M-g e"   . consult-compile-error)
         ("M-g c"   . consult-flycheck)
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
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

;;;;;;;;;;;;;;;;; 09 APPREANCE: THEMES FONTS FACES ;;;;;;;;;;;;;;;;;
;;
;;

(setq custom-safe-themes t)

(defadvice load-theme (before clear-previous-themes activate)
  "Clear existing theme settings instead of layering them"
  (mapc #'disable-theme custom-enabled-themes))

;; (load-theme 'discreet t)
(load-theme 'glaukopis t)
;; (load-theme 'gruber-darker t)
 ;; (load-theme 'gruber-shrews t)
;; (load-theme 'gruvbox-dark-soft t) ;; no worky
;; (load-theme 'material t)
;; (load-theme 'popos t);; more like eire that pop-- takes too much from Zenburn. Should start from scratch.
;; (load-theme 'tsdh-light t)
;; (load-theme 'zenburn t)
;; (set-face-attribute 'region nil :background "#6A5E51" :foreground "#282828") ;; use w/ gruvbox


;;;;; font and faces
;; (set-face-attribute 'default nil :font "Cousine-13")
;; (set-face-attribute 'default nil :font "Victor Mono-13")
;; (set-face-attribute 'default nil :font "Firacode-12")
;; (set-face-attribute 'default nil :font "Hack Nerd Font-12")
;; (set-face-attribute 'default nil :font "Inconsolata-12")
;; (set-face-attribute 'default nil :font "Iosevka Comfy Motion 13")
;; (set-face-attribute 'default nil :font "Iosevka-13")
;; (set-face-attribute 'default nil :font "Menlo-12")
;; (set-face-attribute 'default nil :font "Merriweather")

(add-hook 'text-mode-hook
  (lambda ()
    (variable-pitch-mode 1)))

(set-face-attribute 'default        nil :family "Hack Nerd Font" :height 120 :weight 'regular)
(set-face-attribute 'fixed-pitch    nil :family "Iosveka Comfy"  :height 120 :weight 'medium)
(set-face-attribute 'variable-pitch nil :family "Merriweather"   :height 120 :weight 'medium)


;;; TODO: wanking with gruber-shrews
(custom-set-faces 
 '(Info-quoted       ((t (:foreground "#F15952" :family "Hack-13"))))
 '(minibuffer-prompt ((t (:foreground "#4B919E" :family "Menlo-14"))))

 ;;(setq-default cursor-type 'bar) 
 ;; '(set-cursor-color "#F7BA00")
 ;; )

;;;; Doom-modeline -- I nd??ir??re??
;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode)
;;   :config
;;   (setq doom-modeline-minor-modes t)
;;   (setq doom-modeline-enable-word-count t)
;;   (setq doom-modeline-indent-info t)
;;   (setq doom-modeline-github t)
;;   :init
;;   (doom-modeline-mode))

;;;; PRETIFFY

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
  :ensure t
  ;; :straight t
  :custom
  (setq rainbow-html-colors t)
  ;; TODO: get named-colours to display
  (add-to-list 'rainbow-html-colors-alist 
    '(("gruber-shrews-niagara-1" . "#565f73")
      ("gruber-shrews-niagara"   . "#96a6c8")
      ("gruber-shrews-wisteria"  . "#9e95c7")
  ))
  :init
  (rainbow-mode 1))

;;
;;
;;;;;;;;;;;;;;;;; END APPEARANCE: THEMES FONTS FACES ;;;;;;;;;;;;;;;;;

(use-package notmuch
  :ensure t)

(define-key notmuch-show-mode-map "S"
  (lambda ()
    "delete message and move on"
    (notmuch-show-tag '("+deleted" "-unread"))
    (notmuch-show-next-open-message-or-pop)))

(require 'setup-email)

;;;;;;;;;;;;;;;;; 10 HELP AND INFO ;;;;;;;;;;;;;;;;;
;;
;;

;; help with incomplete key presses
(use-package which-key
  :ensure t
  :custom
  (which-key-show-transient-maps t)
  :init
  (which-key-mode))

;; TODO: get keycast positioned AFTER minor modes!!
(use-package keycast
  :ensure t
  :init
   (add-to-list 'global-mode-string '(" " keycast-mode-line-mode 'APPEND))
   (keycast-mode-line-mode))
(setq mode-line-compact nil)

;; pure silliness
(use-package dim
  :ensure t)

(dim-major-name 'markdown-mode   " ??????")
(dim-major-name 'org-mode        " ????")
(dim-major-name 'emacs-lisp-mode " ????")
(dim-major-name 'calendar-mode   " ????")
(dim-major-name 'inferior-emacs-lisp-mode " ????-")
(dim-major-name 'python-mode     " ????")
(dim-major-name 'rust-mode       " ????")
(dim-major-name 'ruby-mode       " RB") ;; no ruby emoji?
(dim-major-name 'perl-mode       " ????")
;; minor
(dim-minor-name 'isearch-mode       " ????")
(dim-minor-name 'rainbow-mode       " ????")
(dim-minor-name 'undo-tree-mode     " ????")
(dim-minor-name 'which-key-mode     " ??????")
(dim-minor-name 'yas-minor-mode     " ??????" 'YAS)
(dim-minor-name 'visual-line-mode   " ???")
(dim-minor-name 'auto-fill-function " ???")
(dim-minor-name 'view-mode          " ????" 'view)
(dim-minor-name 'eldoc-mode         " ????d" 'eldoc)
(dim-minor-name 'whitespace-mode    " _"  'whitespace)
(dim-minor-name 'paredit-mode       " ()" 'paredit)

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
;; TODO: ??Por qu?? no hay helfpul para describe-mode?
;; C-h a == consult-apropos
(global-set-key (kbd "C-h c")   #'helpful-command)  ;; les interactifs
(global-set-key (kbd "C-h f")   #'helpful-callable) ;; also inc. macros
(global-set-key (kbd "C-h F")   #'helpful-function)
(global-set-key (kbd "C-h v")   #'helpful-variable)
(global-set-key (kbd "C-h k")   #'helpful-key)
(global-set-key (kbd "C-h o")   #'helpful-symbol)
(global-set-key (kbd "C-h p")   #'helpful-at-point)
;;
;;
;;;;;;;;;;;;;;;;; END HELP AND INFO ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 11 EDITING CONVENIENCES ;;;;;;;;;;;;;;;;;
;;
;;
;; I am a savage, not using rectangular actions and, ofc, macros
(use-package multiple-cursors
  :ensure t)

(global-set-key (kbd "C-M-j")       'mc/mark-all-like-this)
(global-set-key (kbd "C-M-/")       'mc/mark-all-in-region)
(global-set-key (kbd "C-M-.")       'mc/mark-next-like-this) ;; THIS IS KEY !!
(global-set-key (kbd "S-M-<down>")  'mc/mark-next-like-this) ;; VSCode
(global-set-key (kbd "C-M-,")       'mc/mark-previous-like-this)
(global-set-key (kbd "S-M-<up>")    'mc/mark-previous-like-this) ;; VSCode

;; M-x unfill-region
;; M-x unfill-paragraph
;; M-x unfill-toggle
(use-package unfill
  :ensure t)

(use-package expand-region
  :ensure t) 
;; keybound abve
;; (global-set-key (kbd "M-r") 'er/expand-region)

(use-package embrace
  ;; https://github.com/cute-jumper/embrace.el
  :ensure t
  )

(global-set-key (kbd "C-,") #'embrace-commander)
(add-hook 'org-mode-hook #'embrace-org-mode-hook)


;; (require 'emacs-surround
;; ;; delete with C-q d <whatever>
;; ;; switch with C-q i <orig> <new>
;; ;; TODO: check https://github.com/rejeep/wrap-region.el
;; (add-to-list 'emacs-surround-alist '("=" . ("=" . "=")))
;; (add-to-list 'emacs-surround-alist '("*" . ("*" . "*")))
;; (add-to-list 'emacs-surround-alist '("~" . ("~" . "~")))
;; (add-to-list 'emacs-surround-alist '("**" . ("**" . "**")))
;; (add-to-list 'emacs-surround-alist '("+" . ("+" . "+")))
;; (add-to-list 'emacs-surround-alist '("_" . ("_" . "_")))
;; (add-to-list 'emacs-surround-alist '("/" . ("/" . "/")))
;; ;; YASnippet better for this
;; (add-to-list 'emacs-surround-alist '("c" . ("`\n" . "\n```")))

;; (global-set-key (kbd "C-q") 'emacs-surround)

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
  (undo-tree-history-directory-alist '(("." . "~/.config/emacs/tmp/undo-tree")))
  (undo-tree-visualizer-timestamps t))

(use-package default-text-scale
  ;; C+M+- and C+M+= across all windows an
  ;; Emacs-q C-x C-- and C-x C-= are per frame
  :defer t
  :config
  (default-text-scale-mode))

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dir "~/.config/emacs/snippets")
  (yas-global-mode 1))    ;; or M-x yas-reload-all

;;
;;
;;;;;;;;;;;;;;;;;  END EDITING CONVENIENCES ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 12  LANGS ;;;;;;;;;;;;;;;;;
;;
;;
;; colorize eshell
(defun sjy2/eshell-mode-faces-glaukopis ()
 ;; https://www.reddit.com/r/emacs/comments/3xw5io/using_a_different_colour_scheme_for_mx_shell/cy98eci/
  "Launch eshell with a slghtly different :background color. Pairs with glaukopis theme"
    (face-remap-add-relative 'default       '((:background "#E4E3CF")))
    (face-remap-add-relative 'line-number   '((:background "#E4E3CF")))
    (face-remap-add-relative 'eshell-prompt '((:foreground "#87CF70" :weight bold))))

(add-hook 'eshell-mode-hook 'sjy2/eshell-mode-faces-glaukopis)

(custom-set-faces
   '(line-number-current-line   ((t (:foreground "#181818" :weight bold)))))


;;; Elisp "enhancements"
(use-package dash
  ;; list API -- https://github.com/magnars/dash.el
  :ensure t
  :config (eval-after-load "dash" '(dash-enable-font-lock)))

(use-package s
  ;; strings -- https://github.com/magnars/s.el
  :ensure t)

(use-package f
  ;; files -- https://github.com/rejeep/f.el
  :ensure t)

;;; parens
;; TODO: Paredit/parinfer ??
 (use-package smartparens
  :config
  (smartparens-global-mode -1)
  (add-hook 'prog-mode-hook #'smartparens-mode))

;; tabular data helper
(use-package csv-mode
  :ensure t)

(use-package kbd-mode
  ;; for Kmonad config files
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package vimrc-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))

(use-package markdown-mode
  ;; :straight t
  :ensure t
  :mode 
  (("README\\.md\\.markdown\\'" . gfm-mode)) ;; github flavour
  :init 
  (setq markdown-command "pandoc")
  ;; :init (setq markdown-command "multimarkdown"))
  (setq markdown-fontify-code-blocks-natively t)
    (add-hook 'markdown-mode-hook
      (lambda ()
        (when buffer-file-name
          (add-hook 'after-save-hook 'check-parens nil t)))))

;;; LaTeX support

(use-package latex
  :after tex
  :ensure auctex
  :hook ((LaTeX-mode . electric-pair-mode)
         (LaTeX-mode . my/latex-with-outline))
  :mode ("\\.tex\\'" . latex-mode)
  :defines (TeX-auto-save
            TeX-parse-self
            TeX-electric-escape
            TeX-PDF-mode
            TeX-source-correlate-method
            TeX-newline-function
            TeX-view-program-list
            TeX-view-program-selection
            TeX-mode-map)
  :bind
  (:map LaTeX-mode-map
   ("M-RET" . LaTeX-insert-item)
   :map TeX-source-correlate-map     
   ([C-down-mouse-1] . TeX-view-mouse)))

;; (use-package auctex
;;   :ensure t
;;   :defer t
;;   :hook (LaTeX-mode .
;; 	  (lambda ()
;; 	    (push (list 'output-pdf "Zathura")
;; 	    TeX-view-program-selection)))) 

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
;; auto-format different source code files extremely intelligently
;; https://github.com/radian-software/apheleia
;; (use-package apheleia
;;   :ensure t
;;   :config
;;   (apheleia-global-mode -1))

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


;;;;;;;;;;;;;;;;; 13 RANDO AND CUSTOM CODE ;;;;;;;;;;;;;;;;;
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

(defun ew/resize-window (&optional arg)
; Hirose Yuuji and Bob Wiener
; https://www.emacswiki.org/emacs/WindowResize
  "*Resize window interactively."
  (interactive "p")
  (if (one-window-p) (error "Cannot resize sole window"))
  (or arg (setq arg 1))
  (let (c)
    (catch 'done
      (while t
	(message
	 "h=heighten, s=shrink, w=widen, n=narrow (by %d);  1-9=unit, q=quit"
	 arg)
	(setq c (read-char))
	(condition-case ()
	    (cond
	     ((= c ?h) (enlarge-window arg))
	     ((= c ?s) (shrink-window arg))
	     ((= c ?w) (enlarge-window-horizontally arg))
	     ((= c ?n) (shrink-window-horizontally arg))
	     ((= c ?\^G) (keyboard-quit))
	     ((= c ?q) (throw 'done t))
	     ((and (> c ?0) (<= c ?9)) (setq arg (- c ?0)))
	     (t (beep)))
	  (error (beep)))))
    (message "Done.")))
(global-set-key (kbd "C-c C-w w") #'ew/resize-window)

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

;; define function to shutdown emacs server instance
(defun ew/server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))


(defun se/dired-create-empty-file ()
  "Create time-stamped org file in dired.
https://emacs.stackexchange.com/questions/55875/how-to-tweak-dired-create-empty-file-to-facilitate-the-easy-creation-of-files"
  (interactive)
  (let* ((ts (format-time-string "%Y-%m-%dT%H.%M.%S" (current-time)))
         (fname (format "%s.org" ts)))
    (dired-create-empty-file fname)
    (find-file fname)))

(defun sjy2/delete-leading-whitespace-in-region (start end)
  "Delete whitespace at the beginning of each line in region."
  (interactive "*r")
  (save-excursion
    (if (not (bolp)) (forward-line 1))
    (delete-whitespace-rectangle (point) end nil)))
(global-set-key (kbd "C-c C-w l") #'sjy2/delete-leading-whitespace-in-region)

(defun sjy2/compress-spaces-in-region (start end)
  "Compress multiple spaces to a single space on a line-by-line basis.
   It does not affect leading or trailing spaces."
  (interactive "r")
  (save-excursion
    (goto-char start)
    (while (re-search-forward " +" end t)
      (replace-match " "))))
(global-set-key (kbd "C-c C-w c") #'sjy2/compress-spaces-in-region)

(defun sjy2/kill-all ()
  (interactive)
  (delete-other-windows)
  (abort-recursive-edit)
  (abort-minibuffers)
  (keyboard-quit))

(defun sjy2/toggle-org-fundamental ()
"Toggle org and fundamental mode"
  (interactive)
   (message "current mode is %s" major-mode)
   (if (eq major-mode 'org-mode)
        ;;(fundamental-mode)
        (major-mode-suspend))
   (if (eq major-mode 'text-mode (or (eq major-mode 'fundamental-mode)))
        (org-mode)))
        
;; (global-set-key (kbd "C-x C-t") 'text-mode) ;; orig transpose lines

(defun sjy2/insert-file-name ()
  "Insert the full path file name into the current buffer."
  (interactive)
  (insert (buffer-file-name)))

(defun sjy2/insert-ISO-date ()
  "Insert a YYYY-MM-DD representation of the current date."
  (interactive)
  (insert (format-time-string "%Y-%m-%dT%H:%m" (current-time))))

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

;; Unfill paragraph
;; replaced with Purcell's unfill package
;; (defun sjy2/unfill-paragraph ()
;;   "Convert a multi-line paragraph into a single line of text."
;;   (interactive)
;;   (let ((fill-column (point-max)))
;; 	(fill-paragraph nil)))
;; (define-key global-map "\M-Q" 'sjy2/unfill-paragraph)



;;
;;
;;;;;;;;;;;;;;;;; END RANDO AND CUSTOM CODE ;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;; 14  WRITING AND SHIT ;;;;;;;;;;;;;;;;;
;;
;;
 

;; (straight-use-package '(fountain-mode
;; https://github.com/rnkn/fountain-mode
;; https://www.youtube.com/watch?v=Be1hE_pQL4w
  ;; :type git
  ;; :host github
  ;; :repo "rnkn/fountain-mode"))

(use-package olivetti
  :ensure t
  :config
  (setq olivetti-body-width 0.65)
  (setq olivetti-minimum-body-width 72)
  (setq olivetti-recall-visual-line-mode-entry-state t))

;; Wordcount minor mode
;; https://github.com/jackrusher/dotemacs/blob/master/modules/07-prose-and-notes.el
(defvar wordcount-timer nil
  "Timer to kick off word count recomputation.")

(defvar wordcount-current-count 0
  "The result of the last word count.")

(defun wordcount-update-word-count ()
  "Recompute the word count."
  (setq wordcount-current-count (count-words (point-min) (point-max))))

(define-minor-mode wordcount-mode
  "Toggle wordcount mode.
With no argument, this command toggles the mode.
A non-null prefix argument turns the mode on.
A null prefix argument turns it off.

When enabled, the word count for the current buffer
is displayed in the mode-line."
  :init-value nil
  :lighter (:eval (format " [%d words]" wordcount-current-count))
  (if wordcount-mode
      (progn
        (set (make-local-variable 'wordcount-current-count)
             (count-words (point-min) (point-max)))
        (set (make-local-variable 'wordcount-timer)
              (run-with-idle-timer 3 't #'wordcount-update-word-count)))
    (cancel-timer wordcount-timer)))

(add-hook 'markdown-mode-hook (lambda () (wordcount-mode)))
;; END wordcount minor mode


;;
;;
;;;;;;;;;;;;;;;;; END WRITING AND SHIT ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 15 ORGMODE ;;;;;;;;;;;;;;;;;
;;
;;
;;; paths
(setq org-directory (expand-file-name "~/_scratch/org"))
(setq org-roam-directory "~/_scratch/org/roam")
(setq org-default-notes-file (concat org-directory "~/_scratch/scratch.org"))

(require 'my-org-capture-templates.el)
;; https://github.com/sk8ingdom/.emacs.d/blob/master/org-mode-config/org-capture-templates.el
;; (load "~/.config/emacs/sjy2-lisp/org-capture-templates")

;;; keybinds
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c l") 'org-store-link)

;;; sane defaults
(setq org-cycle-separator-lines 2
      org-edit-src-content-indentation 2
      org-fontify-quote-and-verse-blocks t
      org-fontify-whole-heading-line t
      org-hide-block-startup nil
      org-hide-emphasis-markers nil
      org-special-ctrl-a/e t
      org-special-ctrl-k t
      org-src-fontify-natively t
      org-src-preserve-indentation nil
      org-src-tab-acts-natively t
      org-startup-folded 'content)

(with-eval-after-load 'org       
  (setq org-startup-indented t) ; Enable `org-indent-mode' by default
  (setq fill-column 80)
;;  (add-hook 'org-mode-hook #'auto-fill-mode)
;;  (add-hook 'auto-fill-mode-on-hook (lambda () (setq fill-column 100)))
  (add-hook 'org-mode-hook #'visual-line-mode))

;; show images by default
(setq-default org-display-inline-images t)
(setq-default org-startup-with-inline-images t)
(setq-default org-display-remote-inline-images t)

(setq org-ctrl-k-protect-subtree t)   ;; DANGER aversion
(setq org-ellipsis "???")
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
;;     "???"
;;     "???"
;;     "???"
;;     "???"
;;     ;; ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ??? ???
;;     ;;; Small
;;     ;; ??? ??? ??? ???
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

;;; Org Roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/_scratch/org/roam")
  (org-roam-completions-everywhere t) ;; faster than completion-at-point
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-note-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point))
  :config
  (org-roam-setup))

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

;;;;;;;;;;;;;;;;; 16 MAIL ;;;;;;;;;;;;;;;;;
;;
;;
;;; mu4e
(load (concat user-emacs-directory
              "sjy2-lisp/mu4e-config.el"))

(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
;;
;;
;;;;;;;;;;;;;;;;; END MAIL ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 17 SOCIAL AND GOOFING ;;;;;;;;;;;;;;;;;
;;
;;
;;; IRC Client
(setq rcirc-server-alist
      '(("irc.libera.chat" :channels ("#emacs" "#org-mode" "#systemcrafters")
         :port 6697 :encryption tls)))
(setq rcirc-default-nick "centzon")
(setq rcirc-prompt "???? "
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

;;; RSS news and all that

(use-package elfeed
 :ensure t
 :config
 (setq elfeed-db-directory (expand-file-name "elfeed" user-emacs-directory)
   elfeed-show-entry-switch 'display-buffer)
 :bind
 ("C-x w" . elfeed ))

;; Feeds are configged in $HOME/_scratch/org/elfeed.org
(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/_scratch/org/elfeed.org")))

;;
;;
;;;;;;;;;;;;;;;;; END SOCIAL AND GOOFING ;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;; 00 XXXX ;;;;;;;;;;;;;;;;;
;;
;;

;; /p??????l??s??fi/
;; /f????l??s??fi/
;; /??????l??s??fi/
;; /f????/
;;
;;
;;;;;;;;;;;;;;;;; END XXXX ;;;;;;;;;;;;;;;;;

(custom-set-variables
  '(whitespace-style
   (quote
    (face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark))))

;;; END of init.el
