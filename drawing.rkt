;#lang slideshow
#lang racket 
(require racket/draw)

(define target (make-bitmap 100 100)) ; A 30x30 bitmap
(define dc (new bitmap-dc% [bitmap target]))
(send dc set-brush (make-color 250 60 70) 'solid)

(send dc draw-rectangle 0 0 100 30)
(send dc draw-rectangle
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high
(send dc draw-line
      0 0    ; Start at (0, 0), the top-left corner
      30 30) ; and draw to (30, 30), the bottom-right corner
(send dc draw-line
      0 30   ; Start at (0, 30), the bottom-left corner
      30 0)  ; and draw to (30, 0), the top-right corner

(send target save-file "box.png" 'png)
