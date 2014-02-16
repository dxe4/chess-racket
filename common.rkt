#lang racket

(define (slice lst i k)
  (if (or (< k i) (<= i 0))
      (error `slice "Incorrect indices!")
      (take (drop lst (sub1 i)) (- k (sub1 i)))))

(define (slice-in-two lst)
  (let ([_size (length lst)]
        [_half_size (/ (length lst) 2)])
  (cons (slice lst 1 _half_size) (slice lst (+ _half_size 1) _size)) 
  ))

;TODO make it generic with recursion remove car cdr
(define unique-absolute-items 
  (lambda (x) 
    (not(eq?(+ (car x) (cdr x)) 0))))

;TODO there must be a way to provide all
(provide slice)
(provide slice-in-two)
(provide unique-absolute-items)