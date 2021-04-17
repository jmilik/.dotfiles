(general-define-key
 :states '(normal visual)
 "w"   'evil-forward-word-end
 "W"   'evil-forward-WORD-end
 "l"   'evil-exchange
 "L"   'evil-exchange-cancel
 "e"   'tol-scroll-previous-line
 "E"   'evil-scroll-line-down
 "i"   'evil-forward-char
 "I"   'evil-previous-line
 "n"   'tol-scroll-next-line
 "N"   'evil-scroll-line-up
 "k"   'evil-backward-char
 "K"   'evil-next-line
 "j"   'evil-yank
 "J"   'evil-yank-line
 "j"   'evil-search-next
 "J"   'evil-search-previous
 "h"   'evil-insert
 "H"   'evil-insert-line
 "C-n" 'evil-join
 "C-e" 'electric-newline-and-maybe-indent
 (general-chord "ne") 'goto-center-line
 (general-chord "en") 'goto-center-line)

(general-define-key
 :states '(normal visual motion emacs)
 :keymaps 'override
 "t"   'evil-visual-char
 "T"   'evil-visual-line
 "s"   'evil-find-char-to
 "S"   'evil-find-char-to-backward)

(defhydra jmilik/hydra-ivy
  (:hint
    nil
   :body-pre
   (progn
     (set-face-attribute 'ivy-current-match nil :weight 'bold)
     (set-face-attribute 'ivy-posframe-cursor nil
      :foreground (face-attribute 'ivy-posframe :background nil 'default)
      :background (face-attribute 'ivy-posframe :background nil 'default)))
   :post 
   (progn
     (set-face-attribute 'ivy-current-match nil :weight 'normal)
     (set-face-attribute 'ivy-posframe-cursor nil
      :foreground (face-attribute 'ivy-posframe :foreground nil 'default)
      :background (face-attribute 'ivy-posframe :foreground nil 'default)))
   :color
    amaranth)
   ("k"        ivy-beginning-of-buffer)
   ("<left>"   ivy-beginning-of-buffer)
   ("n"        ivy-next-line)
   ("<down>"   ivy-next-line)
   ("e"        ivy-previous-line)
   ("<up>"     ivy-previous-line)
   ("o"        ivy-end-of-buffer)
   ("<right>"  ivy-end-of-buffer)
   ("i"        nil)
   ("RET"      ivy-done :exit t)
   ("<escape>" keyboard-escape-quit :exit t))
