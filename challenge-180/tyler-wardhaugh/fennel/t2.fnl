; Task 2 — Trim List

(fn trim-list
  [coll n]
  (icollect [_ v (ipairs coll)]
    (when (< n v) v)))

(fn main
  []
  (match arg
    ["-e" _ i & n]
      (let [result (trim-list n i)]
        (print (string.format "(%s)" (table.concat result ", "))))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: trim-list : main}
