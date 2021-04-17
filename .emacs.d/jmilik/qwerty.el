(general-define-key
 :states '(normal visual)
 "k"   'tol-scroll-previous-line
 "j"   'tol-scroll-next-line
 "C-j" 'evil-join
 "C-k" 'electric-newline-and-maybe-indent
 (general-chord "jk") 'goto-center-line
 (general-chord "kj") 'goto-center-line)

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
   ("h"        ivy-beginning-of-buffer)
   ("<left>"   ivy-beginning-of-buffer)
   ("j"        ivy-next-line)
   ("<down>"   ivy-next-line)
   ("k"        ivy-previous-line)
   ("<up>"     ivy-previous-line)
   ("l"        ivy-end-of-buffer)
   ("<right>"  ivy-end-of-buffer)
   ("i"        nil)
   ("RET"      ivy-done :exit t)
   ("<escape>" keyboard-escape-quit :exit t))
