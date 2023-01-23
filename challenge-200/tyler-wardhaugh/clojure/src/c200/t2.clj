(ns c200.t2)

(def DEFAULT-INPUT [200])

(defn -main
  "Run Task 2 with a given input N defaulting to the first example
  from the task description."
  [& args]
  (let [[n] (or (some->> args (map parse-long)) DEFAULT-INPUT)]
    ))
