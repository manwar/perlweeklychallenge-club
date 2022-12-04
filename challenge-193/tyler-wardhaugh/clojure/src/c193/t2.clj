(ns c193.t2)

(def DEFAULT-INPUT [["adc" "wzy" "abc"]])

(defn diff-array
  [s]
  (let [encoded (map #(-> % int (- (int \a))) s)]
    (map - (rest encoded) encoded)))

(defn odd-string
  [coll]
  (->> coll
       (map (juxt identity diff-array))
       (group-by second)
       (reduce-kv (fn [_ _ v]
                    (when (= (count v) 1)
                      (reduced (ffirst v))))
                  nil)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[COLL] (or args DEFAULT-INPUT)]
    (println (odd-string COLL))))
