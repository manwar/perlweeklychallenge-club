(ns tw.weekly.c91.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Jump Game
;;;

(def DEFAULT-INPUT [1 2 1 2])

(defn jump-game
  "Play the jump game with coll, returning true if we can get to the last
  number, false otherwise"
  [coll]
  (loop [v (vec coll)
         end (dec (count v))
         i 0]
    (if (= i end)
      true
      (let [j (+ i (v i))]
        (cond
          (= i j) false
          (<= j end) (recur v end j)
          :else false)))))

(defn -main
  "Run Task 2 with the given positive integers, defaulting to the example
  given in the explanation page linked from the task description."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (jump-game N) 1 0))))
