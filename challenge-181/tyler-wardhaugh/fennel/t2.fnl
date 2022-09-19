; Task 2 — Hot Day

(local INPUT "../clojure/resources/temperature.txt")

(fn parse-input
  [input]
  (collect [v (io.lines input)]
    (match (: v :find "([%d-]+), (%d+)")
      (_ _ day temp) (values day (tonumber temp)))))

(fn hot-day
  [input]
  (let [days (parse-input input)
        order (doto (icollect [k _ (pairs days)] k) table.sort)]
    (icollect [i k (ipairs order)]
      (let [curr (. days k)
            prev (. days (. order (- i 1)))]
        (when (and prev (< prev curr))
          k)))))

(fn main
  []
  (match arg
    ["-e" _]
      (do
        (each [_ v (ipairs (hot-day INPUT))]
          (print v)
        ""))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))

{: INPUT : hot-day : main}
