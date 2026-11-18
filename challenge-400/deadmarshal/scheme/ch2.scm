(import scheme
        (chicken base)
        srfi-1
        srfi-69)

(define (neighbors gene valid seen)
  (let ((len (string-length gene)))
    (let iloop ((i 0) (acc '()))
      (if (= i len)
          (reverse acc)
          (iloop
           (+ i 1)
           (fold (lambda (c acc)
                   (if (char=? c (string-ref gene i))
                       acc
                       (let ((next (string-copy gene)))
                         (string-set! next i c)
                         (if (and (hash-table-ref/default valid next #f)
                                  (not (hash-table-ref/default seen next #f)))
                             (begin
                               (hash-table-set! seen next #t)
                               (cons next acc))
                             acc))))
                 acc
                 '(#\A #\C #\G #\T)))))))

(define (minimum-genetic-mutation start end bank)
  (if (string=? start end)
      0
      (let ((valid (make-hash-table string=?))
            (seen  (make-hash-table string=?)))
        (for-each (lambda (g) (hash-table-set! valid g #t)) bank)
        (if (not (hash-table-ref/default valid end #f))
            -1
            (begin
              (hash-table-set! seen start #t)
              (let loop ((front (list (cons start 0)))
                         (back '()))
                (cond
                 ((null? front)
                  (if (null? back)
                      -1
                      (loop (reverse back) '())))
                 (else
                  (let* ((gene  (caar front))
                         (steps (cdar front))
                         (next  (neighbors gene valid seen)))
                    (if (member end next)
                        (+ steps 1)
                        (loop (cdr front)
                              (fold (lambda (g acc)
                                      (cons (cons g (+ steps 1)) acc))
                                    back
                                    next))))))))))))


(define (check label got expected)
  (display label)
  (display ": ")
  (display (if (equal? got expected) "ok" "FAIL"))
  (display " (got ")
  (display got)
  (display ", expected ")
  (display expected)
  (display ")")
  (newline))

(check "Example 1"
       (minimum-genetic-mutation "AACCGGTT"
                                 "AACCGGTA"
                                 '("AACCGCTA" "AAACGGTA"))
       -1)

(check "Example 2"
       (minimum-genetic-mutation "AACCGGTT"
                                 "AACCGGAA"
                                 '("AACCGGTA" "AACCGGAA" "AACCGCTA"
                                   "AACCCTAA" "AACCGTAA"))
       2)

(check "Example 3"
       (minimum-genetic-mutation "AAAAAAAA"
                                 "AAAAACCC"
                                 '("CAAAAAAA" "CCAAAAAA" "AAAAAAAC"))
       -1)

(check "Example 4"
       (minimum-genetic-mutation "GAAAAAAA"
                                 "GCCCCCCC"
                                 '("GCAAAAAA" "GCCAAAAA" "GCCCAAAA"
                                   "GCCCCAAA" "GCCCCCAA"
                                   "GCCCCCCA" "GCCCCCCC"))
       7)

(check "Example 5"
       (minimum-genetic-mutation "AACCGGTT"
                                 "AACCGGTT"
                                 '("AACCGGTA"))
       0)


