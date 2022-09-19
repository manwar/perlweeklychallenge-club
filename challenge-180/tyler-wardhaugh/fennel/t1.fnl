; Task 1 — First Unique Character

(fn frequencies
  [coll f]
  (accumulate [tbl {}
               _ c (ipairs coll)]
    (doto tbl (tset c (+ 1 (or (. tbl c) 0))))))

(fn str->list
  [s]
  (icollect [c (s:gmatch ".")] c))

(fn first-unique-char
  [s]
  (let [coll (str->list s)
        freqs (frequencies coll)]
    (accumulate [index nil
                 i c (ipairs coll) :until index]
      (when (= 1 (. freqs c)) (- i 1)))))

(fn main
  []
  (match arg
    ["-e" _ s] (print (first-unique-char s))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: first-unique-char : main}
