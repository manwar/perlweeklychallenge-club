(ns tw.weekly.c136.t2
  (:require [clojure.edn :as edn]
            [tw.weekly.ch-1 :as c77-t1]))

;;;
; Task description for TASK #2 › Fibonacci Sequence
;;;
(def DEFAULT-INPUT [16])

; Reuse our solution from Challenge 77, Task #2 (Fibonacci Sum)
(defn fibo-sum-count
  [n]
  (count (c77-t1/fibo-sum n)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (fibo-sum-count N))))
