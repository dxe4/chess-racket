#lang racket

(define (slice lst i k)
  (if (or (< k i) (<= i 0))
      (error `slice "Incorrect indices!")
      (take (drop lst (sub1 i)) (- k (sub1 i)))))

(define (slice-in-two lst)
  (cons (slice lst 1  (/ (length lst) 2)) (slice lst (+ (/ (length lst) 2) 1) (length lst))) 
  )

(slice-in-two (list 1 2 3 4))
(provide slice)