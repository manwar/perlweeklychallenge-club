(ns c183.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT ['([1,2], [3,4], [5,6], [1,2])])

; In Clojure, data is immutable (except for some specific circumstances), so a
; set removes duplicates even when the elements are themselves lists.
(def unique-array set)

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
   task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (print (-> N unique-array seq))))
