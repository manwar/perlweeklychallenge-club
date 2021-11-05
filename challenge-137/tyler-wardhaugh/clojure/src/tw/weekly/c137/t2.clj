(ns tw.weekly.c137.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #2 › Lychrel Number
;;;
(def DEFAULT-INPUT [56])
(def MAX-TIMES 500)
(def MAX-NUM 10000000)

(defn flip
  [n]
  (Integer/parseInt (-> n str str/reverse)))

(defn lychrel
  [n]
  (loop [n n
         times 1]
    (cond
      (>= times MAX-TIMES) 1
      (>= n MAX-NUM) 1
      (= n (flip n)) 0
      :else (recur (+ n (flip n)) (inc times)))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (lychrel N) 1 0))))
