(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  version-control t
  delete-old-versions t
  kept-new-versions 20
  kept-old-versions 5
  backup-by-copying t)

(setq custom-file null-device
      gc-cons-threshold 20000000)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default truncate-lines t
	      indent-tabs-mode nil)

(setq show-paren-delay 0)
(show-paren-mode t)

(global-hl-line-mode t)

(add-hook 'prog-mode-hook 'linum-mode)

(setq sentence-end-double-space t)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      initial-scratch-message ""
      ring-bell-function 'ignore)

(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq scroll-margin 25
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position t)

(set-face-attribute 'default nil
                    :family "Adobe Source Code Pro"
                    :height 90
                    :weight 'normal
                    :width 'normal)

(setq shell-file-name "bash-for-emacs.sh"
      shell-command-switch "-c")

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package diminish)

(use-package undo-tree
  :diminish)

(use-package evil
  :after undo-tree
  :config
  (evil-mode t))

(use-package evil-escape
  :after evil
  :diminish
  :config
  (evil-escape-mode))

(use-package evil-textobj-line
  :after evil)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-soft t))

(use-package which-key
  :diminish
  :init
  (setq which-key-separator " "
        which-key-prefix-prefix "+"
        max-mini-window-height 0.3
        which-key-allow-evil-operators t
        which-key-show-operator-state-maps t)
  :config
  (which-key-mode t)
  (which-key-setup-minibuffer))

(use-package iedit)

(use-package amx
  :config
  (amx-mode))

(use-package counsel
  :after amx
  :config
  (setq ivy-display-style nil
        ivy-count-format "%d/%d "
        ivy-initial-inputs-alist nil
        ivy-use-virtual-buffers t
        enable-recursive-minibuffers t))

(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode t))

(defun swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter))
(advice-add 'swiper :after #'swiper-recenter)

(use-package ivy-posframe
  :after ivy
  :diminish
  :config
  (setq ivy-posframe-min-width 125
        ivy-posframe-width 125
        ivy-posframe-border-width 2
        ivy-posframe-parameters '((left-fringe . 8) (right-fringe . 8))
        ivy-posframe-display-functions-alist
        '((ivy-switch-buffer                 . ivy-posframe-display-at-frame-center)
          (counsel-M-x                       . ivy-posframe-display-at-frame-center)
          (counsel-imenu                     . ivy-posframe-display-at-frame-center)
          (counsel-recentf                   . ivy-posframe-display-at-frame-center)
          (counsel-bookmark                  . ivy-posframe-display-at-frame-center)
          (counsel-projectile-find-file      . ivy-posframe-display-at-frame-center)
          (counsel-find-file                 . ivy-posframe-display-at-frame-center)
          (counsel-projectile-switch-project . ivy-posframe-display-at-frame-center)
          (dumb-jump-go                      . ivy-posframe-display-at-frame-center)
          (t                                 . nil)))
  (ivy-posframe-enable))

(use-package hydra)

;; TODO - this but better
(use-package ivy-hydra
  :after (ivy hydra))

(use-package dumb-jump
  :after ivy
  :config
  (setq dumb-jump-selector 'ivy
        dumb-jump-prefer-searcher 'rg))

;; TODO projectile

(use-package evil-exchange
  :after evil
  (evil-exchange-install))

(use-package evil-iedit-state
  :after (evil iedit))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode t))

(use-package evil-nerd-commenter
  :after evil)

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode t))

(use-package highlight-parentheses
  :diminish
  :config
  (global-highlight-parentheses-mode t))

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(use-package winum
  :config
  (winum-mode))

(use-package general)

;; TODO isearch iedit bindings

(general-define-key
 "<escape>" 'evil-escape)

(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 :prefix "SPC"
 ;; Misc
 "/"   'counsel-rg
 "TAB" 'switch-to-prev-buffer
 "SPC" 'counsel-M-x
 "!"   'shell-command
 "ot"  'shell
 "r"   'ivy-resume
 ;; Searching in buffers
 "ss"  'swiper
 ;; Files
 "ff"  'counsel-find-file
 "fj"  'dired-jump
 ;; Buffers
 "bb"  'ivy-switch-buffer
 "bd"  'kill-this-buffer
 "bs"  'evil-write
 ;; Window
 "w="  'winum-select-window-by-number
 "w/"  'split-window-right
 "w-"  'split-window-below
 "wd"  'delete-window
 "wo"  'delete-other-windows
 ;; Go to windows
 "1"   '(winum-select-window-1 :wk t)
 "2"   '(winum-select-window-2 :wk t)
 "3"   '(winum-select-window-3 :wk t)
 "4"   '(winum-select-window-4 :wk t)
 "5"   '(winum-select-window-5 :wk t)
 "6"   '(winum-select-window-6 :wk t)
 "7"   '(winum-select-window-7 :wk t)
 "8"   '(winum-select-window-8 :wk t)
 "9"   '(winum-select-window-9 :wk t)
 "0"   '(winum-select-window-0-or-1 :wk t))

(general-define-key
 :states '(normal visual emacs)
 :keymaps 'override
 "Q"   'kill-buffer-and-window)

(general-define-key
 :states '(normal visual)
 "w"   'evil-forward-word-end
 "W"   'evil-forward-WORD-end
 "e"   'evil-exchange
 "E"   'evil-exchange-cancel)

(general-define-key
 :states 'normal
 "C-;" 'evilnc-comment-or-uncomment-lines)

(general-define-key
 :states 'visual
 ";"   'evilnc-comment-or-uncomment-lines)

(general-define-key
 :keymaps 'dired-mode-map
 "<backspace>" 'dired-jump)