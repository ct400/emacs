;;; sjy2-keybinds.el --- Some personal keybinds -*- lexical-binding: t -*-


;;;;;;;;;;;;;;;;; KEYBINDS ;;;;;;;;;;;;;;;;;
;;
;;
;; ESC -- almost proper keyboard-quit
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
;; C-/ is comment/uncomment as in VSCode; is `undo` by default.
(define-key key-translation-map (kbd "C-/") (kbd "C-x C-;"))
;; C-z is undo like CUA
;; (define-key key-translation-map (kbd "C-z") (kbd "C-x u"))
(global-set-key (kbd "C-z") 'undo) ;; C-x u == undo-tree visualizer
;; Yegge -- an alt (hehe!) for M-x
(global-set-key (kbd "C-x C-m")     'execute-extended-command) 
(global-set-key (kbd "C-c C-m")     'execute-extended-command)
(global-set-key (kbd "C-x m")       'execute-extended-command) 
(global-set-key (kbd "C-x C-z")     'repeat)
(global-set-key (kbd "C-x C-.")     'repeat)
(global-set-key (kbd "C-x 5")       'ew/toggle-window-split)
(global-set-key (kbd "C-c t")       'toggle-truncate-lines)
(global-set-key (kbd "C-c b")       'eval-buffer)
(global-set-key (kbd "M-s")         'isearch-forward-regexp)
(global-set-key (kbd "M-r")         'isearch-backwards-regexp)
(defalias 'qrr                      'query-replace-regexp)
;; window movement
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
;; custom functions

(global-set-key (kbd "C-c C-k")     'ew/copy-line)
(global-set-key (kbd "M-<up>")      'ew/move-line-up)
(global-set-key (kbd "M-<down>")    'ew/move-line-down)

;;(global-set-key (kbd "C-q")      'emacs-surround)
;; replaced with embrace
(global-set-key (kbd "M-=")      'er/expand-region)
(global-set-key (kbd "M--")      'er/contract-region)
;; C-, == flyspell next
;; C-. == flyspell correct

(global-set-key (kbd "C-x e")   'end-of-buffer) ;; kmacro-end-and-call-macro
(global-set-key (kbd "C-x a")   'beginning-of-buffer) ;;

;; Steve Yegge had C-w for bacward-word and C-x k for kill-region since C-w is consistent with terminal usage and prevents accidental killing of an overly large block if mark is set some way away.
;; THIS GEM uses kill-region if there is a selection and backwards-word otherwise. GENIUS!!!
;; also check out... https://github.com/Kungsgeten/selected.el

(defadvice kill-region (before unix-werase activate compile)
  "When called interactively with no active region, delete a single word backwards instead."
   (interactive
     (if mark-active (list (region-beginning) (region-end))
       (list (save-excursion (backward-word 1) (point)) (point)))))


(provide 'sjy2-keybinds)

;;; sjy2-keybinds.el ends here
