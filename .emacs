(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq make-backup-files nil)

;; Stop emacs automatically adding config to .emacs
(setq custom-file null-device)

(require 'use-package)
(setq use-package-always-ensure t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
") nil)

(use-package all-the-icons)

;; Dependency for magit and winum
(use-package dash)

(use-package evil
  :after
  undo-tree
  :config
  (evil-mode t)
  ;; Select based on indent level
  (use-package evil-indent-plus
    :config
    (evil-indent-plus-default-bindings))
  (use-package evil-leader
    :config
    (evil-leader/set-leader "<SPC>")
    (global-evil-leader-mode t))
  ;;;; Toggle through CamelCase, snake_case, ALLCAPS, etc
  ;;(use-package evil-string-inflection
  ;;  :after
  ;;  use-package-hydra
  ;;  :bind
  ;;  (:map
  ;;   evil-normal-state-map
  ;;   ("<tab>" . hydra-evil-string-inflection/body))
  ;;  :hydra
  ;;  (hydra-evil-string-inflection (:color red :hint nil)
  ;;   "string-inflect"
  ;;   ("<tab>" evil-operator-string-inflection)))
  ;; Alternate way of toggling through cases
  :config
  (define-key evil-normal-state-map (kbd "<tab> .") 'evil-operator-string-inflection))
  ;; Selecting code blocks
  (use-package evil-surround
    :config
    (global-evil-surround-mode t)))

(use-package hydra)

(use-package link-hint
;;  :bind
;;  (("<SPC> l o" . link-hint-open-link)
;;   ("<SPC> l c" . link-hint-copy-link))
  )

;; Git in emacs
(use-package magit)

;; (use-package persp-mode)???  For fast context switching

;; (use-package popwin)???  For managing popup windows

(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

;; (use-package smex)???  For autocompleting M-x commands

;; Provides good mode-line support
(use-package spaceline
  :after
  (evil, winum)
  :config
  (require 'spaceline-config)
  (spaceline-emacs-theme)
  (use-package all-the-icons
    :config
    (use-package spaceline-all-the-icons
      :config
      (spaceline-all-the-icons-theme))))

;; Easy mass renaming
(use-package symbol-overlay
  :config
  (symbol-overlay-mode t))

;; Dependency for evil
(use-package undo-tree
  :config
  (global-undo-tree-mode t))

;; Define hydra bindings in use-package
(use-package use-package-hydra
  :after
  hydra)

;; Tildes after eof
(use-package vi-tilde-fringe
  :config
  (global-vi-tilde-fringe-mode t))

;; Highlights after pasting/undoing
(use-package volatile-highlights
  :config
  (volatile-highlights-mode t)
  (vhl/define-extension 'evil
			'evil-paste-after 'evil-paste-before
			'evil-paste-pop 'evil-move)
  (vhl/install-extension 'evil))

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
