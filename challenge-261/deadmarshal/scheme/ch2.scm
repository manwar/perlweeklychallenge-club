(define (multiply-by-two list start)
  (if (member start list)
      (multiply-by-two list (* start 2))
      start))

(begin
  (display (multiply-by-two '(5 3 6 1 12) 3)) (newline)
  (display (multiply-by-two '(1 2 4 3) 1)) (newline)
  (display (multiply-by-two '(5 6 7) 2)) (newline))

