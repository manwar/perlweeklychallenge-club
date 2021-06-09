(ns tw.weekly.c115.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › String Chain
;;;
(def DEFAULT-INPUT ["abc" "dea" "cd"])

(defn string-chain
  ""
  [coll])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [S (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (string-chain S))))
