(ns tw.weekly.c106.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Maximum Gap
;;;
(def DEFAULT-INPUT [2 9 3 5])

(defn maximum-gap
  "Determine the maximum difference between two successive elements once coll
  is sorted."
  [coll]
  (let [source (->> (sort coll) (partition 2 1))
        xf (map (fn [[x y]] (- y x)))]
    (transduce xf max 0 source)))

(defn -main
  "Run Task 1 with a given N, defaulting to the example given in the task
  description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (maximum-gap N))))
