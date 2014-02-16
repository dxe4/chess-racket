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

;'(6 -6 12 -12)
(define combos
  (map 
   (lambda (x) (*(car x) (cdr x)))
   (cartesian rook-padding (list 1 -1))))

(define (add-or-remove-pick z)
  (let ([add (lambda (x y) (+ x y))]
        [remove (lambda (x y) (- x y))])
    (cond[(negative? z) (add SQUARE_SIZE z)]
         [else (remove SQUARE_SIZE z)])
    ))

(define (add-or-remove point)
  (map add-or-remove-pick point))

(add-or-remove (list 3 3))
(cons (first (list 3 5)) (rest (list 3 5)) )

(define rook-points 
  (let ([slices (slice-in-two combos)])
  (cartesian (car slices) (cdr slices))
  ))

;(map (add-or-remove rook-points)) TODO tomorrow
(print rook-points)


(define target (make-bitmap 80 80)) ; A 80x80 bitmap

(define dc (new bitmap-dc% [bitmap target]))

(define cool-brush 
  (make-brush #:color(make-color 250 60 70) #:style'solid ))

(define cool-brush-2 
  (make-brush #:color(make-color 50 100 30) #:style'solid ))

(send dc set-brush cool-brush)
;(send dc set-brush cool-brush-2)

;(send dc draw-rectangle 0 0 100 30)

(define zee (new dc-path%))
(send zee move-to 0 0)
(send zee line-to 30 0)
(send zee line-to 0 30)
(send zee line-to 30 30)
(send zee close)
(send dc draw-path zee)
(send target save-file "box.png" 'png)


#|
(send dc draw-rectangle
      0 10   ; Top-left at (0, 10), 10 pixels down from top-left
      30 10) ; 30 pixels wide and 10 pixels high
(send dc draw-line
      0 0    ; Start at (0, 0), the top-left corner
      30 30) ; and draw to (30, 30), the bottom-right corner
(send dc draw-line
      0 30   ; Start at (0, 30), the bottom-left corner
      30 0)  ; and draw to (30, 0), the top-right corner

;-padding-x -padding-y
(define (invert-numbers items) 
  (map (lambda (x)  (* -1 x )) items ))

|#

