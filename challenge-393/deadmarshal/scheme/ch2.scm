(module ch2 (prime-step)
  (import scheme (chicken base))

  (define (prime-step s)
    (define (has-divisor? n i)
      (cond ((> (* i i) n) #f)
	    ((= (modulo n i) 0) #t)
	    (else (has-divisor? n (+ i 1)))))

    (define (prime? n)
      (if (<= n 1)
	  #f
	  (not (has-divisor? n 2))))

    (define (step sum d)
      (if (or (prime? (- sum d)) (prime? (+ sum d)))
	  d
	  (step sum (+ d 1))))

    (define sum
      (apply + (map char->integer (string->list s))))

    (step sum 0)))

(import scheme (chicken base) ch2)

(for-each
 (lambda (e)
   (display e)
   (display " "))
 (map prime-step '("hello" "football" "a" "challenge" "perl")))
(newline)

