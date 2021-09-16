(ns tw.weekly.c130.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2, Binary Search Tree
;;;
(def DEFAULT-INPUT '[(8 (5 (4) (6)) (9))])

(defn bst?
  [tree])

(defn -main
  "Run Task 1 with a given input T, defaulting to the first example from the
  task description."
  [& args]
  (let [[T] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (bst? T) 1 0))))
