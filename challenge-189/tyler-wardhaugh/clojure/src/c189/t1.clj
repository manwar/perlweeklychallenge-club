(ns c189.t1)

(def DEFAULT-INPUT ["emug" "b"])

(defn greater-char
  [coll target]
  (let [source (sort coll)
        xf (comp (filter #(pos? (compare % target))) (take 1))
        f (completing (fn [_ v] v))]
    (transduce xf f target source)))

(defn -main
  "Run Task 1 with a given input COLL and TARGET (both strings), defaulting
  to the first example from the task description."
  [& args]
  (let [[COLL [TARGET & _]] (or args DEFAULT-INPUT)]
    (println (greater-char COLL TARGET))))
