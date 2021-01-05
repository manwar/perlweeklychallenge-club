(ns tw.weekly.c94.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Binary Tree to Linked List
;;;

;        1
;       / \
;      2   3
;     / \
;    4   5
;       / \
;      6   7
(def DEFAULT-INPUT [1 [2 [4] [5 [6] [7]]] [3]])

(defn flatten-tree
  "Flatten a tree to a linked list."
  [tree]
  (->> (tree-seq sequential? seq tree)
       rest
       (filter (complement sequential?))))

(defn -main
  "Run Task 2 with the given tree, defaulting to the example given in the
  task description."
  [& args]
  (let [tree (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "~{~a~^ -> ~}~%" (flatten-tree tree))))
