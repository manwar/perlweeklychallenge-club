(de func (X) 
(let (size (length X))
 (prinl size)
 
)
X)



(de sol (X) 
(make
(let (N 1 size (length X) uniques (uniq X))
   (loop
      (if (= NIL (member N uniques)) 
            (link N)
      )
        (T (< size (inc 'N)) 'done) ) 
      )
)
)

(setq sol1 (sol (list 1 2 1 3 2 5)))
(println sol1)
(setq sol1 (sol (list 1 1 1)))
(println sol1)
(setq sol1 (sol (list 2 2 1)))
(println sol1)
