(ns tw.weekly.c92.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Isomorphic Strings
;;;

(def DEFAULT-INPUT ["abc" "xyz"])

(defn isomorphic?
  "Determine if two strings are isomorphic."
  [a b]
  (let [avals (-> a frequencies vals sort)
        bvals (-> b frequencies vals sort)]
    (= avals bvals)))

(defn -main
  "Run Task 1 using two given strings, defaulting to the example given in
  the task description."
  [& args]
  (let [[A B] (or (some->> args (take 2) edn/read-string) DEFAULT-INPUT)]
    (println (if (isomorphic? A B) 1 0))))
