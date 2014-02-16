#lang racket 
(require racket/draw)

(require racket/include)
(require "cartesian_product.rkt")
(require "common.rkt")

;static
(define SQUARE_SIZE 80)
(define rook-padding-x (quotient  SQUARE_SIZE  12))
(define rook-padding-y (* rook-padding-x 2))
(define rook-padding 
  (list rook-padding-x rook-padding-y))
;-padding-x -padding-y
(define (invert items) 
  (map (lambda (x)  (* -1 x )) items ))

#|
(define unique-absolute-items 
  (lambda (x) 
    (not(eq?(+ (car x) (cdr x)) 0))))

(cartesian rook-padding (invert rook-padding))
(filter unique-items 
        (cartesian rook-padding (invert rook-padding) ))
|#

;'(6 -6 12 -12)
(define combos
  (map 
   (lambda (x) (*(car x) (cdr x)))
   (cartesian rook-padding (list 1 -1))))

(define rook-points 
  (let ([slices (slice-in-two combos)])
  (cartesian (car slices) (cdr slices))
  ))




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
