(ns tw.weekly.c129.t1
  (:require [clojure.edn :as edn]
            [clojure.zip :as zip]))

;;;
; Task description for TASK #1 › Root Distance
;;;
(def DEFAULT-INPUT ['(1 (2) (3 nil (4 (5) (6)))) 6])

(defn root-distance
  [tree node]
  (->> (zip/seq-zip tree)
       (iterate zip/next)
       (take-while (complement zip/end?))
       (drop-while #(not= node (zip/node %)))
       first
       zip/path
       count
       dec))

(defn -main
  "Run Task 1 with a given input T (tree) and N (node), defaulting to the first
  example from the task description."
  [& args]
  (let [[T N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (root-distance T N))))
