(ns c224.t1)

(def DEFAULT-INPUT ["abc" "xyz"])

(defn special-notes?
  [source target]
  (let [s (-> source frequencies)
        t (-> target frequencies (update-vals -))]
    (->> (merge-with + s t)
         vals
         (every? (complement neg?)))))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[SOURCE TARGET] (or args DEFAULT-INPUT)]
    (println (if (special-notes? SOURCE TARGET) "true" "false"))))
