;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'package)
; ;; Any add to list for package-archives (to add marmalade or melpa) goes here
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)

;; BOOTSTRAP STRAIGHT.EL
(defvar bootstrap-version)
(let ((bootstrap-file
        (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
        "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
        'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; USE-PACKAGE CONFIG
;; automatically install use-package if on a fresh system
; (unless (package-installed-p 'use-package)
;   (package-refresh-contents)
;   (package-install 'use-package))
; (eval-when-compile
;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
;   (add-to-list 'load-path "~/.emacs.d/elpa/")
;   (require 'use-package))
; ; (setq use-package-always-ensure t)

;;GENERAL EMACS SETTINGS
;; Disable the splash screen (to enable it again, replace the t with 0)
(setq inhibit-splash-screen t)
(electric-pair-mode t) ;;auto-pairs, eg () [] {}
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(global-visual-line-mode t)

(set-frame-font "Fira Code 14" nil t)
;;Fira Code ligatures
(mac-auto-operator-composition-mode t)

;; TRAMP: disable version control to avoid delays:
(setq vc-ignore-dir-regexp
      (format "\\(%s\\)\\|\\(%s\\)"
	      vc-ignore-dir-regexp
	      tramp-file-name-regexp))

;;Yeah, I should really decompose things
;; auto-pair $ with $
(add-hook 'LaTeX-mode-hook
	  (lambda () (set (make-local-variable 'TeX-electric-math)
			  (cons "$" "$"))))
(eval-after-load "tex" 
  '(setcdr (assoc "LaTeX" TeX-command-list)
	   '("%`%l%(mode) -shell-escape%' %t"
	     TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")))

(defun er-find-user-init-file ()
  "Edit the `user-init-file', in *this* window."
  (interactive)
  (find-file user-init-file))

(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

It returns the buffer (for elisp programing).

URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "untitled")))
    (switch-to-buffer-other-window $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf))

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
 '(package-selected-packages
   (quote
    (auctex org-journal evil-org use-package evil-surround magit material-theme airline-themes evil-commentary spaceline))))
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

(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq TeX-auto-save t))

(use-package mac-pseudo-daemon
  :straight (mac-pseudo-daemon :type git :host github :repo "DarwinAwardWinner/mac-pseudo-daemon")
  :config
  (mac-pseudo-daemon-mode t))

(use-package org
  :ensure t
  :config
  (setq org-log-done t)
  (setq org-agenda-files (quote ("~/org/todo.org")))
  (setq org-catch-invisible-edits (quote show-and-error))
  (setq org-default-notes-file (concat org-directory "/capture.org"))
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen
  (global-set-key (kbd "C-c l") 'org-store-link)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c c") 'org-capture))

(use-package org-roam
      :after org
      :hook 
      (after-init . org-roam-mode)
      :straight (:host github :repo "jethrokuan/org-roam" :branch "develop")
      :custom
      (org-roam-directory "~/org/"))

(use-package org-journal
  :ensure t
  :defer t
  :custom
  (org-journal-find-file 'find-file)
  (org-journal-dir "~/org/journal/")
  (org-journal-date-format "%A, %d %B %Y"))

(use-package helm
  :ensure t
  :config 
  (helm-mode t))

(use-package evil
  :ensure t
  :init
  ;(setq evil-want-C-i-jump nil) ;cuz C-i and TAB are same in terminal
  :config 
  ;; Make evil-mode up/down operate in screen lines instead of logical lines
  (define-key evil-motion-state-map "j" 'evil-next-visual-line)
  (define-key evil-motion-state-map "k" 'evil-previous-visual-line)
  ;; Also in visual mode
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  ; (define-key evil-motion-state-map (kbd "C-c i") 'evil-jump-forward)

  (evil-mode t))

(unless (display-graphic-p)
  (use-package evil-terminal-cursor-changer
    :ensure t
    :init
    (setq evil-motion-state-cursor 'box)  ; █
    (setq evil-visual-state-cursor 'box)  ; █
    (setq evil-normal-state-cursor 'box)  ; █
    (setq evil-insert-state-cursor 'bar)  ; ⎸
    (setq evil-emacs-state-cursor  'hbar) ; _
    :config
    (etcc-on)))

(use-package evil-commentary
  :ensure t 
  :config 
  (evil-commentary-mode t))

(defun find-todo-file ()
  "Edit the todo.org file, in *this* window."
  (interactive)
  (find-file (concat org-directory "/todo.org")))

(use-package evil-leader
  :ensure t
  :config
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key ;active in all modes
    "b" 'switch-to-buffer
    "f" 'find-file
    "g" 'magit-status
    "i" 'er-find-user-init-file
    "j" 'org-journal-new-entry
    "o" 'xah-new-empty-buffer
    "p" 'switch-to-prev-buffer
    "q" 'delete-other-windows
    "t" 'find-todo-file
    "w" 'save-buffer)
  (evil-leader/set-key-for-mode 'org-mode ;just for org-mode, normal state
    "n i" 'org-roam-insert
    "n l" 'org-roam
    "n f" 'org-roam-find-file
    "n g" 'org-roam-show-graph)
  ;; (evil-leader/set-key-for-mode 'org-roam-mode ;just for org-mode, normal state
  (global-evil-leader-mode t))

;;intialize
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode t))

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

(use-package magit
  :ensure t)


