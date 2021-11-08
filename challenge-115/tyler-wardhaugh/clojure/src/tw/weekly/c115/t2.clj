(ns tw.weekly.c115.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Largest Multiple
;;;
(def DEFAULT-INPUT [1 0 2 6])

(defn largest-multiple
  "Determine the largest mulitple that can be formed using coll"
  [coll]
  (let [min-even (->> coll (filter even?) (reduce min))
        freqs (-> coll frequencies (update min-even dec))
        remaining (into [] (mapcat (fn [[num x]] (repeat x num))) freqs)]
    (->> remaining
         sort
         (concat [min-even])
         reverse
         (reduce str "")
         (Integer/parseInt))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (largest-multiple N))))
