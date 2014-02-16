#lang racket 
(require racket/draw)

(require racket/include)
(require "cartesian_product.rkt")


(define SQUARE_SIZE 80)
(define rook-padding-x (/  SQUARE_SIZE  13))
(define rook-padding-y (* rook-padding-x 2))

(define rook-padding (cons rook-padding-x (cons rook-padding-y empty)))

(define (invert items) 
  (map (lambda (x)  (* -1 x )) items ))
(cartesian rook-padding (invert rook-padding) )

(define target (make-bitmap 80 90)) ; A 30x30 bitmap

(define dc (new bitmap-dc% [bitmap target]))
(define cool-brush 
  (make-brush #:color(make-color 250 60 70) #:style'solid ))
(send dc set-brush cool-brush)

(define cool-brush-2 
  (make-brush #:color(make-color 50 100 30) #:style'solid ))

(send dc draw-rectangle 0 0 100 30)
(send dc set-brush cool-brush-2)
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
