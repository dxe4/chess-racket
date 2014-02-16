#lang racket
(provide cartesian)
;; say hello to our friends in stack overflow
;; http://stackoverflow.com/questions/1658229/scheme-lisp-nested-loops-and-recursion

; curry takes:
;  * a p-argument function AND
;  * n actual arguments,
; and returns a function requiring only (p-n) arguments
; where the first "n" arguments are already bound. A simple
; example
; (define add1 (curry + 1))
; (add1 3)
;  => 4
; Many other languages implicitly "curry" whenever you call
; a function with not enough arguments.
(define curry
    (lambda (f . c) (lambda x (apply f (append c x)))))

; take a list of tuples and an element, return another list
; with that element stitched on to each of the tuples:
; e.g.
; > (stitch '(1 2 3) 4)
; ((4 . 1) (4 . 2) (4 . 3))
(define stitch
    (lambda (tuples element)
        (map (curry cons element) tuples)))

; Flatten takes a list of lists and produces a single list
; e.g.
; > (flatten '((1 2) (3 4)))
; (1 2 3 4)
(define flatten
    (curry apply append))

; cartesian takes two lists and returns their cartesian product
; e.g.
; > (cartesian '(1 2 3) '(4 5))
; ((1 . 4) (1 . 5) (2 . 4) (2 . 5) (3 . 4) (3 . 5))
(define cartesian
    (lambda (l1 l2)
        (flatten (map (curry stitch l2) l1))))

; cartesian-lists takes a list of lists
; and returns a single list containing the cartesian product of all of the lists.
; We start with a list containing a single 'nil', so that we create a
; "list of lists" rather than a list of "tuples".

; The other interesting function we use here is "fold-right" (sometimes called
; "foldr" or "reduce" in other implementations). It can be used
; to collapse a list from right to left using some binary operation and an
; initial value.
; e.g.
; (fold-right cons '() '(1 2 3))
; is equivalent to
; ((cons 1 (cons 2 (cons 3 '())))
; In our case, we have a list of lists, and our binary operation is to get the
; "cartesian product" between each list.
(define cartesian-lists
    (lambda (lists)
        (foldr cartesian '(()) lists)))

; cartesian-map takes a n-argument function and n lists
; and returns a single list containing the result of calling that
; n-argument function for each combination of elements in the list:
; > (cartesian-map list '(a b) '(c d e) '(f g))
; ((a c f) (a c g) (a d f) (a d g) (a e f) (a e g) (b c f)
;  (b c g) (b d f) (b d g) (b e f) (b e g))
(define cartesian-map
    (lambda (f . lists)
        (map (curry apply f) (cartesian-lists lists))))