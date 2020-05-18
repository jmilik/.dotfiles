(require 'evil)

(setq-default tol-scroll-region-max-lines 9
              tol-scroll-region-max-percent 0.3
              tol-scroll-end-buffer-max-lines 5
              tol-scroll-end-buffer-max-percent 0.15)

(defun tol-scroll/first-line-in-window ()
  (line-number-at-pos (window-start)))

(defun tol-scroll/last-line-in-window ()
  (+ (tol-scroll/first-line-in-window) (window-height) (- 1)))

(defun tol-scroll/window-larger-than-file ()
  (< (window-height) (count-screen-lines)))

(defun tol-scroll/number-lines-in-half-window ()
  (/ (window-height) 2))

(defun tol-scroll/center-line ()
  (+ (tol-scroll/first-line-in-window) (tol-scroll/number-lines-in-half-window)))

(defun tol-scroll/tol-size-by-max-percent (percent)
  (floor (* percent (tol-scroll/number-lines-in-half-window))))

(defun tol-scroll/half-tol-region-size ()
  (min tol-scroll-region-max-lines
       (tol-scroll/tol-size-by-max-percent tol-scroll-region-max-percent)))

(defun tol-scroll/top-line-of-tol-region ()
  (- (tol-scroll/center-line) (tol-scroll/half-tol-region-size)))

(defun tol-scroll/bottom-line-of-tol-region ()
  (+ (tol-scroll/center-line) (tol-scroll/half-tol-region-size)))

(defun tol-scroll/cursor-in-tol-region (count)
  (and
    (>= (+ (line-number-at-pos) count) (tol-scroll/top-line-of-tol-region))
    (<= (+ (line-number-at-pos) count) (tol-scroll/bottom-line-of-tol-region))))

(defun tol-scroll/movement-crosses-tol-region-boundary (count)
  (and
   (tol-scroll/cursor-in-tol-region 0)
   (not (tol-scroll/cursor-in-tol-region count))))

(defun tol-scroll/tol-end-buffer-size ()
  (min tol-scroll-end-buffer-max-lines
       (tol-scroll/tol-size-by-max-percent tol-scroll-end-buffer-max-percent)))

(defun tol-scroll/cursor-outside-tol-of-buffer-end ()
  (< (tol-scroll/last-line-in-window)
     (+ (count-screen-lines) (tol-scroll/tol-end-buffer-size))))

(evil-define-motion tol-scroll-previous-line (count)
  "Move the cursor up COUNT lines.
If movement would take cursor outside tolerance region, scroll buffer too."
  :type line
  (interactive "p")
  (if (and (bound-and-true-p tol-scroll-mode)
           (tol-scroll/movement-crosses-tol-region-boundary (- (or count 1)))
           (tol-scroll/window-larger-than-file))
      (progn
        (evil-scroll-line-up (or count 1))
        (evil-previous-line (or count 1)))
      (evil-previous-line (or count 1))))

(evil-define-motion tol-scroll-next-line (count)
  "Move the cursor down COUNT lines.
If movement would take cursor outside tolerance region, scroll buffer too."
  :type line
  (interactive "p")
  (if (and (bound-and-true-p tol-scroll-mode)
           (tol-scroll/movement-crosses-tol-region-boundary (or count 1))
           (tol-scroll/window-larger-than-file)
           (tol-scroll/cursor-outside-tol-of-buffer-end))
      (progn
        (evil-scroll-line-down (or count 1))
        (evil-next-line (or count 1)))
      (evil-next-line (or count 1))))

(define-minor-mode tol-scroll-mode
  "Minor mode for centered scrolling within tolerance regions"
  :global t
  :init-value nil
  :lighter " tol-scroll")

(provide 'tol-scroll)
