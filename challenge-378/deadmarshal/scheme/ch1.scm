(import (chicken sort))

(define (delete-duplicates lst)
  (let loop ((lst lst) (result '()))
    (cond ((null? lst) (reverse result))
          ((member (car lst) result) (loop (cdr lst) result))
          (else (loop (cdr lst) (cons (car lst) result))))))

(define (extract-digits str)
  (let loop ((i 0) (digits '()))
    (if (= i (string-length str))
        (reverse digits)
        (let ((c (string-ref str i)))
          (if (char-numeric? c)
              (loop (+ i 1) (cons (- (char->integer c) 48) digits))
              (loop (+ i 1) digits))))))

(define (second-largest-digit str)
  (let* ((digits (extract-digits str))
	 (uniq (delete-duplicates digits))
	 (sorted (sort uniq >)))
    (if (>= (length sorted) 2)
	(cadr sorted)
	-1)))

(define (displayln x) (display x) (newline))

(displayln (second-largest-digit "aaaaa77777"))
(displayln (second-largest-digit "abcde"))
(displayln (second-largest-digit "9zero8eight7seven9"))
(displayln (second-largest-digit "xyz9876543210"))
(displayln (second-largest-digit "4abc4def2ghi8jkl2"))

