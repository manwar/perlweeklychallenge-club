(ns tw.weekly.c96.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › Reverse Words
;;;

(def DEFAULT-INPUT "The Weekly Challenge")

(defn reverse-words
  "Split a string by spaces and reassemble in reverse word order."
  [s]
  (-> s
      str/trim
      (str/split #"\s+")
      reverse
      (->> (str/join " "))))

(defn -main
  "Run Task 1 using a string S, defaulting to the example given in
  the task description."
  [& args]
  (let [S (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (reverse-words S))))
