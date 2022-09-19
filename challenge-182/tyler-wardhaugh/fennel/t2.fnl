; Task 2 — Common Paths

(local DEFAULT-INPUT
  ["/a/b/c/1/x.pl"
   "/a/b/c/d/e/2/x.pl"
   "/a/b/c/d/3/x.pl"
   "/a/b/c/4/x.pl"
   "/a/b/c/d/5/x.pl"])

(fn common-path
  [coll]
  (let [ncoll (length coll)
        parts (icollect [_ path (ipairs coll)]
                (icollect [part (-> path (: :gmatch "(/*[^/]*/*)"))]
                  part))
        result (icollect [i v (ipairs (. parts 1))]
                 (when (= ncoll (accumulate [sum 0 _ p (ipairs parts)]
                                  (+ sum (if (= v (. p i)) 1 0))))
                   v))]
    (table.concat result "")))

(fn main
  []
  (match arg
    (where ["-e" _ & n] (< 0 (length n))) (print (common-path n))
    ["-e" _ & n] (print (common-path DEFAULT-INPUT))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: main : common-path : DEFAULT-INPUT}
