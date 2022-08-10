(princ (cl-loop for i from 1 upto 200 for s = (number-to-string i)
  for m = (string-match "0" s) for c = (string-to-number(concat s "0" (reverse s)))
  for p = (car (math-prime-test c 1)) for d = (and (not m) p) for n = 0 then (if d (+ n 1) n)
  while (< n 20) if d  collect c )))
