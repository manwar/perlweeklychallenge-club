(ns tw.weekly.c96.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Edit Distance
;;;

(def DEFAULT-INPUT ["kitten" "sitting"])

(defn edit-distance
  "Compute the minimum operations required to convert S1 to S2."
  [s1 s2]
  (let [ed (fn [f [h1 & t1 :as s1] [h2 & t2 :as s2]]
             (cond
               (empty? s1) (count s2)
               (empty? s2) (count s1)
               (= h1 h2) (f f t1 t2)
               :else (->> [[t1 s2]
                           [s1 t2]
                           [t1 t2]]
                          (transduce (map (partial apply f f)) min ##Inf)
                          inc)))
        ed' (memoize ed)]
    (ed' ed' (seq s1) (seq s2))))

(defn -main
  "Run Task 2 using strings S1 and S2, defaulting to the example given in
  the task description."
  [& args]
  (let [[S1 S2] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (edit-distance S1 S2))))
