(ns tw.weekly.c93.t2
  (:require [clojure.edn :as edn]
            [clojure.zip :as z]))

;;;
; Task description for TASK #2 › Sum Path
;;;

;     1
;     /
;    2
;   / \
;  3   4
(def DEFAULT-INPUT [1 [2 [3] [4]]])

(defn is-leaf?
  "Is node `n` a leaf node?"
  [n] (nil? (z/down n)))

(defn has-no-children?
  "Does node `n` have children?"
  [n] (nil? (z/right n)))

(defn sum-paths
  "Sum all root-to-leaf paths of a given tree."
  [tree]
  (let [paths (->>
                tree
                z/vector-zip
                (iterate z/next)
                (take-while (complement z/end?))
                (filter is-leaf?)
                (filter has-no-children?)
                (map #(->> % z/path (map z/node))))]
    (transduce (map (partial reduce +)) + paths)))

(defn -main
  "Run Task 2 with the given tree of integers, defaulting to the example
  given in the explanation page linked from the task description."
  [& args]
  (let [tree (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (sum-paths tree))))
