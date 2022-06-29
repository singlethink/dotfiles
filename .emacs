(setq load-path (cons "~/.emacs.d/elisp" load-path))

(let ((default-directory  "/usr/local/share/emacs/site-lisp"))
  (normal-top-level-add-subdirs-to-load-path))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)

;; Turn on font-lock mode for Emacs
(global-font-lock-mode t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;; default emacs c-mode SUCKS, this is the c-mode for the linux kernel
(defun linux-c-mode ()
  "C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (setq c-basic-offset 8))

;; use linux-c in the /usr/src/linux directory
(setq auto-mode-alist (cons '("/usr/src/linux.*/.*\\.[ch]$" . linux-c-mode)
                       auto-mode-alist))

;; use stroustrup style as the default style in c++ minor mode
(defun my-c++-mode-hook ()
  (c-set-style "stroustrup"))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(put 'downcase-region 'disabled nil)

(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\.yml$" . yaml-mode))

;; Enable emacs to find our non-standard ispell
(setq-default ispell-program-name "/usr/local/bin/ispell")
(add-hook 'text-mode-hook 'flyspell-mode)  ; enable flyspell mode for text-mode

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(ns-command-modifier (quote meta)))

;; Turn on line number and font lock modes
(setq line-number-mode t)
(turn-on-font-lock )

;; Turn off hard tabs because they're causing Terry headaches
(setq-default indent-tabs-mode nil)

;; org-mode settings

(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(setq org-directory "~/repos/meta")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(setq org-agenda-files '("~/repos/meta/inbox.org"
			 "~/repos/meta/todo.org"
			 "~/repos/meta/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/repos/meta/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/repos/meta/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/repos/meta/todo.org" :maxlevel . 3)
                           ("~/repos/meta/someday.org" :level . 1)
                           ("~/repos/meta/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

;; Start the emacs sever so that we don't have to have multiple copies
;; of emacs flying around
(server-start)

