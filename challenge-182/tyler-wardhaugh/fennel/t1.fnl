; Task 1 — Max Index

(local DEFAULT-INPUT [5 2 9 1 7 6])

(fn max-index
  [coll]
  (var [max-i max-v] [nil nil])
  (each [i v (ipairs coll)]
    (when (or (not max-i) (< max-v v))
      (set [max-i max-v] [i v])))
  (- max-i 1))

(fn main
  []
  (match arg
    (where ["-e" _ & n] (< 0 (length n))) (print (max-index n))
    ["-e" _ & n] (print (max-index DEFAULT-INPUT))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: main : max-index}
