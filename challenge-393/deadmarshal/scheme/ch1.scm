(module ch1 (pythagoras-multiplied)
  (import scheme)

  (define (pythagoras-multiplied n)
    (define (gcd* a b)
      (if (= b 0) a (gcd* b (modulo a b))))

    (define (inner m k n count)
      (if (>= k m)
          count
          (let* ((c (+ (* m m) (* k k)))
                 (add (if (and (odd? (- m k))
                               (<= c n)
                               (= (gcd* m k) 1))
                          (* 2 (quotient n c))
                          0)))
            (inner m (+ k 1) n (+ count add)))))

    (define (outer m n count)
      (if (<= (+ (* m m) 1) n)
          (outer (+ m 1) n (inner m 1 n count))
          count))

    (outer 2 n 0)))

(import scheme (chicken base) ch1)

(for-each
 (lambda (e)
   (display e)
   (display " "))
 (map pythagoras-multiplied '(20 7 1 15 30)))
(newline)

