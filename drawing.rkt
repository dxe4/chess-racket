#lang racket 
(require racket/draw)

(require racket/include)
(require "cartesian_product.rkt")
(require "common.rkt")

;static
(define SQUARE_SIZE 80)
(define rook-bottom-box (quotient SQUARE_SIZE 10))
(define rook-padding-x (quotient  SQUARE_SIZE  4))
(define rook-padding-y (quotient  SQUARE_SIZE  6))
(define rook-padding 
  (list rook-padding-x rook-padding-y))


;'(6 -6 12 -12)
(define combos
  (map 
   (lambda (x) (*(car x) (cdr x)))
   (cartesian rook-padding (list 1 -1))))

(define (add-or-remove-pick z)
    (cond[(negative? z) (+ SQUARE_SIZE z)]
         [else (+ 0 z)]))

;hack fix this
(define (add-or-remove point)
  (map add-or-remove-pick (list (car point) (cdr point))))

(define rook-points 
  (let ([slices (slice-in-two combos)])
  (cartesian (car slices) (cdr slices))
  ))

(set! rook-points
  (sort rook-points (lambda (x y) (< (cdr x) (cdr y)))))


(set! rook-points
      (map  add-or-remove rook-points))

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

(define (rook-down-path point-a point-b move-up)
  (let ([p (new dc-path%)]
        [x-a (first point-a)]
        [y-a (second point-a)]
        [x-b (first point-b)]
        [y-b (second point-b)])
    (send p move-to x-a y-a)
    (send p line-to x-b y-b)
    (send p line-to x-b (- y-b move-up))
    (send p line-to x-a (- y-a move-up))
    (send p close)
    p))

(define test 
  (rook-down-path (first rook-points) (second rook-points) rook-bottom-box))
(send dc draw-path test)
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

