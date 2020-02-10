;; -*- mode: elisp -*-

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)
;; Any add to list for package-archives (to add marmalade or melpa) goes here
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)

;; USE-PACKAGE CONFIG
;; automatically install use-package if on a fresh system
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "/Users/ketanagrawal/.emacs.d/elpa/")
  (require 'use-package))

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)
(add-hook 'python-mode-hook
    (lambda ()
	(define-key python-mode-map "\"" 'electric-pair)
	(define-key python-mode-map "\'" 'electric-pair)
	(define-key python-mode-map "(" 'electric-pair)
	(define-key python-mode-map "[" 'electric-pair)
	(define-key python-mode-map "{" 'electric-pair)))



(load-theme 'material t)

;; Org mode settings
(require 'org)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-log-done t)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c616e584f7268aa3b63d08045a912b50863a34e7ea83e35fcab8537b75741956" "3eb93cd9a0da0f3e86b5d932ac0e3b5f0f50de7a0b805d4eb1f67782e9eb67a4" "b59d7adea7873d58160d368d42828e7ac670340f11f36f67fa8071dbf957236a" default)))
 '(org-agenda-files
   (quote
    ("~/org/test.org" "/Users/ketanagrawal/org/test.org" "/Users/ketanagrawal/org/test2.org")))
 '(org-default-notes-file (concat org-directory "/capture.org"))
 '(package-selected-packages
   (quote
    (use-package evil-surround magit material-theme airline-themes evil-commentary spaceline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(require 'airline-themes)
(load-theme 'airline-kolor)

;; EVIL SETTINGS
;;require
(require 'evil)
(require 'evil-commentary)
(require 'evil-leader)
(require 'evil-surround)
;;intialize
(global-evil-leader-mode t)
(evil-mode t)
(evil-commentary-mode t)
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "w" 'save-buffer)

;; Shortcut to edit init.el
(defun er-find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") #'er-find-user-init-file)

;;MAGIT SETTINGS
(global-set-key (kbd "C-x g") 'magit-status)
