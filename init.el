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
(setq use-package-always-ensure t)

;; Disable the splash screen (to enable it again, replace the t with 0)
(setq inhibit-splash-screen t)
(menu-bar-mode -1)


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
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(org-catch-invisible-edits (quote show-and-error))
 '(org-default-notes-file (concat org-directory "/capture.org"))
 '(package-selected-packages
   (quote
    (evil-org use-package evil-surround magit material-theme airline-themes evil-commentary spaceline))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox-dark-hard t))

;; (use-package dracula-theme
;;   :ensure t
;;   :config
;;   (load-theme 'dracula t))

(use-package airline-themes
  :ensure t
  :config
  (load-theme 'airline-dark))

;; Org mode settings
(use-package org
  :ensure t
  :config
  (setq org-log-done t)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
;; EVIL SETTINGS
;; load evil
(use-package evil
  :ensure t
  :config ;; tweak evil after loading it
  (evil-mode))

(use-package  
(unless (display-graphic-p)
          (require 'evil-terminal-cursor-changer)
          (evil-terminal-cursor-changer-activate) ; or (etcc-on)
          )

(use-package evil-commentary
  :ensure t ;; install the evil package if not installed
  :config ;; tweak evil after loading it
  (evil-commentary-mode 1))

(use-package evil-leader
  :ensure t
  :init
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "w" 'save-buffer)
  :config
  (global-evil-leader-mode 1))

;;intialize
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
	      (evil-org-set-key-theme '(textobjects insert navigation additional shift todo heading))))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
;; (setq evil-want-C-i-jump nil) ;; C-i and TAB are same in terminal

;; Shortcut to edit init.el
(defun er-find-user-init-file ()
  "Edit the `user-init-file', in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") #'er-find-user-init-file)

;;MAGIT SETTINGS
(global-set-key (kbd "C-x g") 'magit-status)

