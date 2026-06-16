(define (sum-of-words a b c)
  (define (f n)
    (let loop ((i 0) (r 0))
      (if (= i (string-length n))
	  r
	  (loop (+ i 1)
		(+ (* r 10)
		   (- (char->integer (string-ref n i)) 97))))))  
  (= (+ (f a) (f b)) (f c)))

(for-each
 (lambda (t) (print (apply sum-of-words t)))
 '(("acb" "cba" "cdb") ("aab" "aac" "ad") ("bc" "je" "jg")
   ("a" "aaaa" "aa") ("c" "d" "h") ("gfi" "hbf" "bdhd")))

