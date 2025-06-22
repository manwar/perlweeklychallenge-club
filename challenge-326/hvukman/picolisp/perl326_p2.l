
(de decomp (X)
(make
(link (make (do (car (nth X 1)) (link (car (nth X 2))))))
(link (make (do (car (nth X 3)) (link (car (nth X 4))))))
)
)

(decomp '(1 3 2 4))
(decomp '(1 1 2 2))
(decomp '(3 1 3 2))