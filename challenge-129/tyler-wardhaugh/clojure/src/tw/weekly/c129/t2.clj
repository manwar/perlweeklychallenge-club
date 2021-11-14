(ns tw.weekly.c129.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2, Add Linked Lists
;;;

; Traditionally, in Lisps the standard list is a linked list; therefore the
; core language (and standard library) contain a multitude of functions for
; dealing with them. In that vein, we'll use the built-in list for this task.
(def DEFAULT-INPUT ['(1 2 3) '(3 2 1)])

(defn list->num
  [coll]
  (->> (map * (reverse coll) (iterate #(* 10 %) 1))
       (reduce +)))

(defn num->list
  [n]
  (->> n str (map #(Character/digit % 10))))

(defn add-lists
  [& colls]
  (-> (transduce (map list->num) + colls)
      num->list))

(defn -main
  "Run Task 1 with a given inputs L1 and L2, defaulting to the first example
  from the task description."
  [& args]
  (let [[L1 L2] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~{~a~^ -> ~}~%" (add-lists L1 L2))))
