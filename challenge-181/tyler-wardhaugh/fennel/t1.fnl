; Task 1 — Sentence Order

(local INPUT "../clojure/resources/input1.txt")

(fn slurp
  [file]
  (let [f (assert (io.open file))]
    (values (f:read "*a") (f:close))))

(fn longest-width
  [text]
  (let [lengths (icollect [lines (: text :gmatch "([^\n]+)")]
                  (length lines))]
    (math.max (table.unpack lengths))))

(fn ->sentences
  [text]
  (icollect [s (-> text (: :gmatch "([^%.]+)"))] s))

(fn ->words
  [text]
  (icollect [s (-> text (: :gmatch "([%w',]+)"))] s))

(fn stable-sort-words
  [tbl]
  (let [index (collect [i k (ipairs tbl)] k i)]
    (->>
      (fn [a b]
        (let [la (: a :lower)
              lb (: b :lower)]
          (if (= la lb)
            (< (. index a) (. index b))
            (< la lb))))
      (table.sort tbl))))

(fn word-wrap
  [graf width lead]
  (let [practical-width (- width (length lead))
        practical-lead (: lead :sub 1 -2)
        lines []]
    (var remaining practical-width)
    (var current [practical-lead])
    (each [_ sentence (ipairs graf)]
      (local sentence-count (length sentence))
      (each [i word (ipairs sentence)]
        (let [word (if (= i sentence-count) (.. word ".") word)]
          (if (> (+ 1 (length word)) remaining)
            (do
              (table.insert lines (table.concat current " "))
              (set current [practical-lead word])
              (set remaining (- practical-width (length word))))
            (do
              (table.insert current word)
              (set remaining (- remaining (length word) 1)))))))
    (table.insert lines (table.concat current " "))
    (table.concat lines "\n")))

(fn sentence-order
  [input]
  (let [text (slurp INPUT)
        lead (: text :match "^%s+")
        sentences (icollect [_ s (ipairs (->sentences text))]
                    (doto (->words s) stable-sort-words))]
    (word-wrap sentences (longest-width text) lead)))

(fn main
  []
  (match arg
    ["-e" _] (print (sentence-order INPUT))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: main : sentence-order : slurp : INPUT}
