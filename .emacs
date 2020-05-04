(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  version-control t
  ;; How many versions to keep
  delete-old-versions t
  kept-new-versions 20
  kept-old-versions 5
  ;; Don't delink hardlinks
  backup-by-copying t)

;; Stop emacs automatically adding config to .emacs
(setq custom-file null-device)

;; When paren is under the cursor, highlight its complement
(show-paren-mode t)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; Don't wrap lines
(setq-default truncate-lines t
	      indent-tabs-mode nil)

;; Scroll one line at a time after more than 10 lines from center
(setq scroll-margin 10
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;; Minimal appearance
(setq inhibit-splash-screen t
      inhibit-startup-message t
      initial-scratch-message ""
      ring-bell-function 'ignore)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Emacs' garbage collection is overly aggressive
(setq gc-cons-threshold 20000000)

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t)

;; Auto-completion
;;(use-package company
;;  :config
;;  (use-package company-statistics
;;    :config
;;    (add-hook 'after-init-hook 'company-statistics-mode)))

(use-package counsel
  :after
  ivy
  :config
  (counsel-mode))

;; Dependency for magit and winum
(use-package dash)

(use-package dumb-jump
  :config
  (setq dumb-jump-selector 'ivy
        dumb-jump-prefer-searcher 'rg))

;; Define consistent style rules for code
;; (use-package editor-config)

(use-package evil
  :after
  (iedit undo-tree)
  :config
  (evil-mode t)
  (use-package evil-escape
    :config
    (global-set-key (kbd "<ESC> <ESC> <ESC>") 'evil-escape)
    (setq-default evil-escape-delay 0.25)
    (evil-escape-mode))
  ;; Exchange text objects
  (use-package evil-exchange
    :config
    (evil-exchange-cx-install))
  ;; Highlight hints
  (use-package evil-goggles
    :config
    (evil-goggles-mode)
    (setq evil-goggles-pulse t
	  evil-goggles-enable-undo t)
    (evil-goggles-use-diff-faces))
  (use-package evil-iedit-state)
  ;; Select based on indent level
  (use-package evil-indent-plus
    :config
    (evil-indent-plus-default-bindings))
  (use-package evil-leader
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode t))
  ;; Alignment tools
  (use-package evil-lion
    :config
    (evil-lion-mode))
  (use-package evil-matchit
    :config
    (global-evil-matchit-mode t))
  ;; Makes commenting an evil operation
  (use-package evil-nerd-commenter)
  ;; Toggle through CamelCase, snake_case, ALLCAPS, etc
  (use-package evil-string-inflection
    :config
    (define-key evil-normal-state-map (kbd "<tab> .") 'evil-operator-string-inflection))
  ;; Selecting code blocks
  (use-package evil-surround
    :config
    (global-evil-surround-mode t))
  ;; Make a line an evil text object so you can eg 'cil'
  (use-package evil-textobj-line))

;; Define window layouts like a window manager
;; (use-package eyebrowse)

;; Fuzzy matching engine
(use-package flx)

(use-package flx-ido
  :config
  (ido-mode t)
  (ido-everywhere t)
  (flx-ido-mode t)
  (setq ido-enable-flex-matching t
	ido-use-faces nil))

(use-package highlight-indent-guides
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character))

(use-package highlight-numbers
  :init
  (add-hook 'prog-mode-hook 'highlight-numbers-mode))

(use-package highlight-parentheses
  :config
  (global-highlight-parentheses-mode t))

(use-package hl-todo
  :config
  (global-hl-todo-mode t)
  (setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF"))))
  ;;(define-key hl-todo-mode-map (kbd "<SPC> t p") 'hl-todo-previous)
  ;;(define-key hl-todo-mode-map (kbd "<SPC> t n") 'hl-todo-next)
  ;;(define-key hl-todo-mode-map (kbd "<SPC> t l") 'hl-todo-occur)
  ;;(define-key hl-todo-mode-map (kbd "<SPC> t i") 'hl-todo-insert))

(use-package iedit)

(use-package ivy
  :config
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))
        ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        enable-recursive-minibuffers t)
  (ivy-mode)
  (use-package ivy-xref
    :config
    (setq xref-show-definitions-function #'ivy-xref-show-defs
	  xref-show-xrefs-function #'ivy-xref-show-xrefs)))

;;(use-package link-hint)
;;  :bind
;;  (("<SPC> l o" . link-hint-open-link)
;;   ("<SPC> l c" . link-hint-copy-link))

;; Git in emacs
;;(use-package magit)

;; (use-package persp-mode)???  For fast context switching

;; (use-package popwin)???  For managing popup windows

;; Dependency for spaceline
(use-package powerline)

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; For autocompleting M-x commands
(use-package smex
  :config
  (smex-initialize))

;; Provides good mode-line support
(use-package spaceline
  :after
  (evil powerline winum)
  :config
  (require 'spaceline-config)
  (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-on)
  (use-package all-the-icons
    :config
    (use-package spaceline-all-the-icons
      :config
      (spaceline-all-the-icons-theme))))

(use-package swiper
  :after
  ivy)

;; Easy mass renaming
(use-package symbol-overlay
  :config
  (symbol-overlay-mode t))

;; Dependency for evil
(use-package undo-tree
  :config
  (global-undo-tree-mode t)
  (define-key evil-normal-state-map "u" 'undo-tree-undo)
  (define-key evil-normal-state-map "\C-r" 'undo-tree-redo))

;; Define hydra bindings in use-package
(use-package use-package-hydra
  :after
  hydra)

;; Tildes after eof
(use-package vi-tilde-fringe
  :config
  (global-vi-tilde-fringe-mode t))

;; Contextual key-help popup
(use-package which-key
  :config
  (which-key-mode t)
  (which-key-setup-minibuffer)
  (setq max-mini-window-height 0.3
	which-key-allow-evil-operators t
	which-key-show-operator-state-maps t))

;; Number windows
(use-package winum
  :config
  ;; Number is provided by spaceline
  (setq winum-auto-setup-mode-line nil)
  (winum-mode t))
