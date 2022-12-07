;;; gruber-shrews-theme.el --- Gruber Shrews color theme for Emacs

;; Copyright (C) 2022 Stephen Yearl
;; Copyright (C) 2013-2016 Alexey Kutepov a.k.a rexim
;; Copyright (C) 2009-2010 Jason R. Blevins


;; Permission is hereby granted, free of charge, to any person
;; obtaining a copy of this software and associated documentation
;; files (the "Software"), to deal in the Software without
;; restriction, including without limitation the rights to use, copy,
;; modify, merge, publish, distribute, sublicense, and/or sell copies
;; of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
;; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
;; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
;; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
;; SOFTWARE.

;;; Commentary:
;;
;; This is basically a 2022-11-27 fork of Rexim's Gruber Darker, colours
;; made more gooder and bluer in the style of Shrewsbury Town Football Club.
;; I don't even like football. 
;;
;; Author: ct400
;; URL: http://github.com/ct400/gruber-shrews-theme
;; 
;; Gruber Darker color theme for Emacs by Jason Blevins. A darker
;; variant of the Gruber Dark theme for BBEdit by John Gruber. Adapted
;; for deftheme and extended by Alexey Kutepov a.k.a. rexim.


(deftheme gruber-shrews
  "Gruber Shrews color theme")

;; Please, install rainbow-mode.

(let ((gruber-shrews-fg        "#E4E3CF")
      (gruber-shrews-fg-1      "#E2CEBD")
      (gruber-shrews-fg+1      "#f5f5f5")
      (gruber-shrews-fg+2      "#f4f4ff")
      (gruber-shrews-bg-3      "#002244")
      (gruber-shrews-bg-2      "#00295E")
      (gruber-shrews-bg-1      "#1A4065");;"#003355"
      (gruber-shrews-bg        "#001133");;"#001439"
      (gruber-shrews-bg+1      "#003B79")
      (gruber-shrews-bg+2      "#2E5292")
      (gruber-shrews-bg+3      "#4889C7")
      (gruber-shrews-topaz     "#60D1B9")
      (gruber-shrews-coffee-1  "#52494e")
      (gruber-shrews-coffee    "#CA9F73")
      (gruber-shrews-white     "#F0F0F0")
      (gruber-shrews-black     "#181818")
      (gruber-shrews-red-1     "#8B0000")
      (gruber-shrews-red       "#c73c3f")
      (gruber-shrews-red+1     "#F15952")
      (gruber-shrews-green-1   "#569034")
      (gruber-shrews-green     "#87CF70")    
      (gruber-shrews-yellow-1  "#d0b045")     
      (gruber-shrews-yellow    "#F7BA00")
      (gruber-shrews-brown     "#cc8c3c")
      (gruber-shrews-quartz    "#95a99f")
      (gruber-shrews-niagara-2 "#303540")
      (gruber-shrews-niagara-1 "#565f73")
      (gruber-shrews-niagara   "#96a6c8")
      (gruber-shrews-wisteria  "#9e95c7")
      )      
  (custom-theme-set-variables
   'gruber-shrews
   '(frame-brackground-mode (quote dark)))

  (custom-theme-set-faces
   'gruber-shrews

   ;; Agda2
   `(agda2-highlight-datatype-face ((t (:foreground ,gruber-shrews-quartz))))
   `(agda2-highlight-primitive-type-face ((t (:foreground ,gruber-shrews-quartz))))
   `(agda2-highlight-function-face ((t (:foreground ,gruber-shrews-niagara))))
   `(agda2-highlight-keyword-face ((t ,(list :foreground gruber-shrews-yellow
                                             :bold t))))
   `(agda2-highlight-inductive-constructor-face ((t (:foreground ,gruber-shrews-green))))
   `(agda2-highlight-number-face ((t (:foreground ,gruber-shrews-wisteria))))

   ;; AUCTeX
   `(font-latex-bold-face ((t (:foreground ,gruber-shrews-quartz :bold t))))
   `(font-latex-italic-face ((t (:foreground ,gruber-shrews-quartz :italic t))))
   `(font-latex-math-face ((t (:foreground ,gruber-shrews-green))))
   `(font-latex-sectioning-5-face ((t ,(list :foreground gruber-shrews-niagara
                                             :bold t))))
   `(font-latex-slide-title-face ((t (:foreground ,gruber-shrews-niagara))))
   `(font-latex-string-face ((t (:foreground ,gruber-shrews-green))))
   `(font-latex-warning-face ((t (:foreground ,gruber-shrews-red))))

   ;; Basic Coloring (or Uncategorized)
   `(border ((t ,(list :background gruber-shrews-bg-1
                       :foreground gruber-shrews-bg+2))))
   `(cursor ((t (:background ,gruber-shrews-yellow))))
   `(default ((t ,(list :foreground gruber-shrews-fg
                        :background gruber-shrews-bg))))
   `(fringe ((t ,(list :background gruber-shrews-bg-1
                       :foreground gruber-shrews-bg+2))))
   `(link ((t (:foreground ,gruber-shrews-niagara :underline t))))
   `(link-visited ((t (:foreground ,gruber-shrews-wisteria :underline t))))
   `(match ((t (:background ,gruber-shrews-bg+3))))
   `(shadow ((t (:foreground ,gruber-shrews-bg+3))))
   `(minibuffer-prompt ((t (:foreground ,gruber-shrews-wisteria))))
   `(region ((t (:background ,gruber-shrews-bg+3 :foreground nil))))
   `(secondary-selection ((t ,(list :background gruber-shrews-quartz ;;bg+3
                                    :foreground nil))))
   `(trailing-whitespace ((t ,(list :foreground gruber-shrews-black
                                    :background gruber-shrews-red))))
   `(tooltip ((t ,(list :background gruber-shrews-bg+3
                        :foreground gruber-shrews-white))))

   ;; Calendar
   `(holiday-face ((t (:foreground ,gruber-shrews-red))))

   ;; Compilation
   `(compilation-info ((t ,(list :foreground gruber-shrews-green
                                 :inherit 'unspecified))))
   `(compilation-warning ((t ,(list :foreground gruber-shrews-brown
                                    :bold t
                                    :inherit 'unspecified))))
   `(compilation-error ((t (:foreground ,gruber-shrews-red+1))))
   `(compilation-mode-line-fail ((t ,(list :foreground gruber-shrews-red
                                           :weight 'bold
                                           :inherit 'unspecified))))
   `(compilation-mode-line-exit ((t ,(list :foreground gruber-shrews-green
                                           :weight 'bold
                                           :inherit 'unspecified))))

   ;; Custom
   `(custom-state ((t (:foreground ,gruber-shrews-green))))

   ;; Diff
   `(diff-removed ((t ,(list :foreground gruber-shrews-red+1
                             :background nil))))
   `(diff-added   ((t ,(list :foreground gruber-shrews-green
                             :background nil))))

   ;; Dired
   `(dired-directory ((t (:foreground ,gruber-shrews-niagara :weight bold))))
   `(dired-ignored   ((t ,(list :foreground gruber-shrews-quartz
                                :inherit 'unspecified))))
   `(dired-flagged   ((t (:foreground ,gruber-shrews-red+1))));;"#F15952"



   ;; Ebrowse
   `(ebrowse-root-class ((t (:foreground ,gruber-shrews-niagara :weight bold))))
   `(ebrowse-progress   ((t (:background ,gruber-shrews-niagara))))

   ;; Egg
   `(egg-branch           ((t (:foreground ,gruber-shrews-yellow))))
   `(egg-branch-mono      ((t (:foreground ,gruber-shrews-yellow))))
   `(egg-diff-add         ((t (:foreground ,gruber-shrews-green))))
   `(egg-diff-del         ((t (:foreground ,gruber-shrews-red))))
   `(egg-diff-file-header ((t (:foreground ,gruber-shrews-wisteria))))
   `(egg-help-header-1    ((t (:foreground ,gruber-shrews-yellow))))
   `(egg-help-header-2    ((t (:foreground ,gruber-shrews-niagara))))
   `(egg-log-HEAD-name    ((t (:box (:color ,gruber-shrews-fg)))))
   `(egg-reflog-mono      ((t (:foreground ,gruber-shrews-niagara-1))))
   `(egg-section-title    ((t (:foreground ,gruber-shrews-yellow))))
   `(egg-text-base        ((t (:foreground ,gruber-shrews-fg))))
   `(egg-term             ((t (:foreground ,gruber-shrews-yellow))))

   ;; ERC
   `(erc-notice-face    ((t (:foreground ,gruber-shrews-wisteria))))
   `(erc-timestamp-face ((t (:foreground ,gruber-shrews-green))))
   `(erc-input-face     ((t (:foreground ,gruber-shrews-red+1))))
   `(erc-my-nick-face   ((t (:foreground ,gruber-shrews-red+1))))

   ;; EShell
   `(eshell-ls-backup     ((t (:foreground ,gruber-shrews-quartz))))
   `(eshell-ls-directory  ((t (:foreground ,gruber-shrews-niagara))))
   `(eshell-ls-executable ((t (:foreground ,gruber-shrews-green))))
   `(eshell-ls-symlink    ((t (:foreground ,gruber-shrews-yellow))))

   ;; Font Lock
   `(font-lock-builtin-face           ((t (:foreground ,gruber-shrews-yellow))))
   `(font-lock-comment-face           ((t (:foreground ,gruber-shrews-brown))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,gruber-shrews-brown))))
   `(font-lock-constant-face          ((t (:foreground ,gruber-shrews-quartz))))
   `(font-lock-doc-face               ((t (:foreground ,gruber-shrews-green))))
   `(font-lock-doc-string-face        ((t (:foreground ,gruber-shrews-green))))
   `(font-lock-function-name-face     ((t (:foreground ,gruber-shrews-niagara))))
   `(font-lock-keyword-face           ((t (:foreground ,gruber-shrews-yellow :bold t))))
   `(font-lock-preprocessor-face      ((t (:foreground ,gruber-shrews-quartz))))
   `(font-lock-reference-face         ((t (:foreground ,gruber-shrews-quartz))))
   `(font-lock-string-face            ((t (:foreground ,gruber-shrews-green))))
   `(font-lock-type-face              ((t (:foreground ,gruber-shrews-quartz))))
   `(font-lock-variable-name-face     ((t (:foreground ,gruber-shrews-fg+1))))
   `(font-lock-warning-face           ((t (:foreground ,gruber-shrews-red))))

   ;; Flymake
   `(flymake-errline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-shrews-red)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:foreground ,gruber-shrews-red :weight bold :underline t))))
   `(flymake-warnline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-shrews-yellow)
                       :foreground unspecified
                       :background unspecified
                       :inherit unspecified))
        (t (:forground ,gruber-shrews-yellow :weight bold :underline t))))
   `(flymake-infoline
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-shrews-green)
                   :foreground unspecified
                   :background unspecified
                   :inherit unspecified))
      (t (:forground ,gruber-shrews-green :weight bold :underline t))))

   ;; Flyspell
   `(flyspell-incorrect
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-shrews-red) :inherit unspecified))
      (t (:foreground ,gruber-shrews-red :weight bold :underline t))))
   `(flyspell-duplicate
     ((((supports :underline (:style wave)))
       (:underline (:style wave :color ,gruber-shrews-yellow) :inherit unspecified))
      (t (:foreground ,gruber-shrews-yellow :weight bold :underline t))))

   ;; Helm
   `(helm-candidate-number ((t ,(list :background gruber-shrews-bg+2
                                      :foreground gruber-shrews-yellow
                                      :bold t))))
   `(helm-ff-directory    ((t ,(list  :foreground gruber-shrews-niagara
                                      :background gruber-shrews-bg
                                      :bold t))))
   `(helm-ff-executable   ((t (:foreground ,gruber-shrews-green))))
   `(helm-ff-file         ((t (:foreground ,gruber-shrews-fg :inherit unspecified))))
   `(helm-ff-invalid-symlink ((t ,(list :foreground gruber-shrews-bg
                                        :background gruber-shrews-red))))
   `(helm-ff-symlink ((t (:foreground ,gruber-shrews-yellow :bold t))))
   `(helm-selection-line ((t (:background ,gruber-shrews-bg+1))))
   `(helm-selection ((t (:background ,gruber-shrews-bg+1 :underline nil))))
   `(helm-source-header ((t ,(list :foreground gruber-shrews-yellow
                                   :background gruber-shrews-bg
                                   :box (list :line-width -1
                                              :style 'released-button)))))

   ;; Ido
   `(ido-first-match ((t (:foreground ,gruber-shrews-yellow :bold nil))))
   `(ido-only-match  ((t (:foreground ,gruber-shrews-brown :weight bold))))
   `(ido-subdir      ((t (:foreground ,gruber-shrews-niagara :weight bold))))

   ;; Info
   `(info-xref    ((t (:foreground ,gruber-shrews-niagara))))
   `(info-visited ((t (:foreground ,gruber-shrews-wisteria))))

   ;; Jabber
   `(jabber-chat-prompt-foreign    ((t ,(list :foreground gruber-shrews-quartz
                                              :bold nil))))
   `(jabber-chat-prompt-local      ((t (:foreground ,gruber-shrews-yellow))))
   `(jabber-chat-prompt-system     ((t (:foreground ,gruber-shrews-green))))
   `(jabber-rare-time-face         ((t (:foreground ,gruber-shrews-green))))
   `(jabber-roster-user-online     ((t (:foreground ,gruber-shrews-green))))
   `(jabber-activity-face          ((t (:foreground ,gruber-shrews-red))))
   `(jabber-activity-personal-face ((t (:foreground ,gruber-shrews-yellow :bold t))))

    ;; Line Highlighting
    `(highlight                   ((t (:background ,gruber-shrews-bg-1 :foreground nil))))
    `(highlight-current-line-face ((t ,(list :background gruber-shrews-bg+1
                                             :foreground nil))))

   ;; orderless
    `(orderless-match-face-0 ((t (:background ,gruber-shrews-topaz    :foreground nil))))
    `(orderless-match-face-1 ((t (:background ,gruber-shrews-wisteria :foreground nil)))) 
    `(orderless-match-face-2 ((t (:background ,gruber-shrews-white    :foreground nil)))) 
    `(orderless-match-face-3 ((t (:background ,gruber-shrews-bg+3     :foreground nil)))) 

   ;; vertico
   `(vertico-current ((t (:inherit default :foreground ,gruber-shrews-brown))))
   `(vertico-quick1  ((t (:inherit italic))))
   `(vertico-quick2  ((t (:inherit bold))))


   ;; visible-mark
  `(visible-mark-active ((t (:background ,gruber-shrews-brown :foreground nil))))

   ;; line numbers
   `(line-number              ((t (:inherit default :foreground ,gruber-shrews-coffee-1))))
   `(line-number-current-line ((t (:inherit line-number :foreground ,gruber-shrews-yellow))))

   ;; Linum
   `(linum ((t `(list :foreground gruber-shrews-quartz
                      :background gruber-shrews-bg))))

   ;; Magit
   `(magit-branch           ((t (:foreground ,gruber-shrews-niagara))))
   `(magit-diff-hunk-header ((t (:background ,gruber-shrews-bg+2))))
   `(magit-diff-file-header ((t (:background ,gruber-shrews-coffee-1))))
   `(magit-log-sha1         ((t (:foreground ,gruber-shrews-red+1))))
   `(magit-log-author       ((t (:foreground ,gruber-shrews-brown))))
   `(magit-log-head-label-remote ((t ,(list :foreground gruber-shrews-green
                                            :background gruber-shrews-bg+1))))
   `(magit-log-head-label-local  ((t ,(list :foreground gruber-shrews-niagara
                                            :background gruber-shrews-bg+1))))
   `(magit-log-head-label-tags   ((t ,(list :foreground gruber-shrews-yellow
                                            :background gruber-shrews-bg+1))))
   `(magit-log-head-label-head   ((t ,(list :foreground gruber-shrews-fg
                                            :background gruber-shrews-bg+1))))
   `(magit-item-highlight   ((t (:background ,gruber-shrews-bg+1))))
   `(magit-tag ((t ,(list :foreground gruber-shrews-yellow
                          :background gruber-shrews-bg))))
   `(magit-blame-heading ((t ,(list :background gruber-shrews-bg+1
                                    :foreground gruber-shrews-fg))))

   ;; Message
   `(message-header-name ((t (:foreground ,gruber-shrews-green))))

   ;; markdown-mode
   `(markdown-blockquote-face  ((t (:inherit 'normal))))
   `(markdown-bold-face        ((t (:inherit 'bold))))
   `(markdown-header-face      ((t (:foreground "#4B919E"  :height 1.2 :family "Menlo"))))
   `(markdown-italic-face      ((t (:slant oblique :underline t :height 1.1 :family "Iosevka"))))
   `(markdown-markup-face      ((t (:foreground "#569034" :height 0.9))))
   `(markdown-pre-face         ((t (:foreground ,gruber-shrews-coffee))))

   ;; Marginalia
   `(marginalia-documentation ((t (:foreground ,gruber-shrews-wisteria))))

   ;; Mode Line
   `(mode-line           ((t ,(list :background gruber-shrews-bg+1
                                    :foreground gruber-shrews-fg+2))))
   `(mode-line-buffer-id ((t ,(list :background gruber-shrews-bg+1
                                    :foreground gruber-shrews-fg+2))))
   `(mode-line-inactive  ((t ,(list :background gruber-shrews-bg+1
                                    :foreground gruber-shrews-quartz))))

   ;; keycast-mode
   `(keycast-key      ((t (:background "#002244" :foreground "#CC8C3C"
	                   :weight bold  :box (:line-width -1 :style released-button)))))
   `(keycast-command  ((t (:foreground "#CC8C3C"  :box (:line-width -1 :style released-button)))))
   
   ;; Neo Dir
   `(neo-dir-link-face ((t (:foreground ,gruber-shrews-niagara))))

   ;; Org Mode
   `(org-agenda-structure ((t (:foreground ,gruber-shrews-niagara))))
   `(org-column ((t (:background ,gruber-shrews-bg-1))))
   `(org-column-title ((t (:background ,gruber-shrews-bg-1 :underline t :weight bold))))
   `(org-done ((t (:foreground ,gruber-shrews-green))))
   `(org-todo ((t (:foreground ,gruber-shrews-red-1))))
   `(org-upcoming-deadline ((t (:foreground ,gruber-shrews-yellow))))
   
 `(org-block ((t (:background ,gruber-shrews-bg-2 :foreground ,gruber-shrews-niagara))))
   

   

   ;; Search
   `(isearch ((t ,(list :foreground gruber-shrews-black
                        :background gruber-shrews-fg+2))))
   `(isearch-fail ((t ,(list :foreground gruber-shrews-black
                             :background gruber-shrews-red))))
   `(isearch-lazy-highlight-face ((t ,(list
                                       :foreground gruber-shrews-fg+1
                                       :background gruber-shrews-niagara-1))))

   ;; Sh
   `(sh-quoted-exec ((t (:foreground ,gruber-shrews-red+1))))

   ;; Show Paren
   `(show-paren-match-face ((t (:background ,gruber-shrews-coffee-1))))
   `(show-paren-mismatch-face ((t (:background ,gruber-shrews-red-1))))

   ;; Slime
   `(slime-repl-inputed-output-face ((t (:foreground ,gruber-shrews-red))))

   ;; Tuareg
   `(tuareg-font-lock-governing-face ((t (:foreground ,gruber-shrews-yellow))))

   ;; Speedbar
   `(speedbar-directory-face ((t ,(list :foreground gruber-shrews-niagara
                                        :weight 'bold))))
   `(speedbar-file-face ((t (:foreground ,gruber-shrews-fg))))
   `(speedbar-highlight-face ((t (:background ,gruber-shrews-bg+1))))
   `(speedbar-selected-face ((t (:foreground ,gruber-shrews-red))))
   `(speedbar-tag-face ((t (:foreground ,gruber-shrews-yellow))))

   ;; Which Function
   `(which-func ((t (:foreground ,gruber-shrews-wisteria))))

   ;; Whitespace
   `(whitespace-space ((t ,(list :background gruber-shrews-bg
                                 :foreground gruber-shrews-bg+1))))
   `(whitespace-tab ((t ,(list :background gruber-shrews-bg
                               :foreground gruber-shrews-bg+1))))
   `(whitespace-hspace ((t ,(list :background gruber-shrews-bg
                                  :foreground gruber-shrews-bg+2))))
   `(whitespace-line ((t ,(list :background gruber-shrews-bg+2
                                :foreground gruber-shrews-red+1))))
   `(whitespace-newline ((t ,(list :background gruber-shrews-bg
                                   :foreground gruber-shrews-bg+2))))
   `(whitespace-trailing ((t ,(list :background gruber-shrews-red
                                    :foreground gruber-shrews-red))))
   `(whitespace-empty ((t ,(list :background gruber-shrews-yellow
                                 :foreground gruber-shrews-yellow))))
   `(whitespace-indentation ((t ,(list :background gruber-shrews-yellow
                                       :foreground gruber-shrews-red))))
   `(whitespace-space-after-tab ((t ,(list :background gruber-shrews-yellow
                                           :foreground gruber-shrews-yellow))))
   `(whitespace-space-before-tab ((t ,(list :background gruber-shrews-brown
                                            :foreground gruber-shrews-brown))))

   ;; tab-bar
   `(tab-bar ((t (:background ,gruber-shrews-bg+1 :foreground ,gruber-shrews-coffee-1))))
   `(tab-bar-tab ((t (:background nil :foreground ,gruber-shrews-yellow :weight bold))))
   `(tab-bar-tab-inactive ((t (:background nil))))

   ;; vterm / ansi-term
   `(term-color-black ((t (:foreground ,gruber-shrews-bg+3 :background ,gruber-shrews-coffee-1))))
   `(term-color-red ((t (:foreground ,gruber-shrews-red-1 :background ,gruber-shrews-red-1))))
   `(term-color-green ((t (:foreground ,gruber-shrews-green :background ,gruber-shrews-green))))
   `(term-color-blue ((t (:foreground ,gruber-shrews-niagara :background ,gruber-shrews-niagara))))
   `(term-color-yellow ((t (:foreground ,gruber-shrews-yellow :background ,gruber-shrews-yellow))))
   `(term-color-magenta ((t (:foreground ,gruber-shrews-wisteria :background ,gruber-shrews-wisteria))))
   `(term-color-cyan ((t (:foreground ,gruber-shrews-quartz :background ,gruber-shrews-quartz))))
   `(term-color-white ((t (:foreground ,gruber-shrews-fg :background ,gruber-shrews-white))))

   ;;;;; company-mode
   `(company-tooltip ((t (:foreground ,gruber-shrews-fg :background ,gruber-shrews-bg+1))))
   `(company-tooltip-annotation ((t (:foreground ,gruber-shrews-brown :background ,gruber-shrews-bg+1))))
   `(company-tooltip-annotation-selection ((t (:foreground ,gruber-shrews-brown :background ,gruber-shrews-bg-1))))
   `(company-tooltip-selection ((t (:foreground ,gruber-shrews-fg :background ,gruber-shrews-bg-1))))
   `(company-tooltip-mouse ((t (:background ,gruber-shrews-bg-1))))
   `(company-tooltip-common ((t (:foreground ,gruber-shrews-green))))
   `(company-tooltip-common-selection ((t (:foreground ,gruber-shrews-green))))
   `(company-scrollbar-fg ((t (:background ,gruber-shrews-bg-1))))
   `(company-scrollbar-bg ((t (:background ,gruber-shrews-bg+2))))
   `(company-preview ((t (:background ,gruber-shrews-green))))
   `(company-preview-common ((t (:foreground ,gruber-shrews-green :background ,gruber-shrews-bg-1))))

   ;;;;; Proof General
   `(proof-locked-face ((t (:background ,gruber-shrews-niagara-2))))
   ))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'gruber-shrews)

;; Local Variables:
;; no-byte-compile: t
;; indent-tabs-mode: nil
;; eval: (when (fboundp 'rainbow-mode) (rainbow-mode +1))
;; End:

;;; gruber-shrews-theme.el ends here.
