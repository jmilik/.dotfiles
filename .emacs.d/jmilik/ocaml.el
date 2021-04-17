(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

(use-package tuareg
  :load-path opam-share
  :mode ("\\.ml[ily]?$" . tuareg-mode)
  :config
  (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp")))) (setenv (car var) (cadr var)))
  (setq exec-path (split-string (getenv "PATH") path-separator)))

(use-package ocp-indent
  :load-path opam-share)

(use-package ocp-index
  :load-path opam-share)

(use-package merlin
  :after tuareg
  :load-path opam-share
  :hook (tuareg-mode . merlin-mode)
  :config
  (setq merlin-command 'opam
        merlin-use-auto-complete-mode 'easy))

(use-package utop
  :after tuareg
  :load-path opam-share
  :hook (tuareg-mode . utop-minor-mode)
  :config
  (setq utop-command "utop -emacs"))
