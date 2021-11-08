(ns tw.weekly.c114.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › Next Palindrome Number
;;;
(def DEFAULT-INPUT 1234)

(defn next-palindrome
  [n]
  (let [source (->> n inc (iterate inc))
        xf (filter #(apply = ((juxt identity str/reverse) (str %))))]
    (->> source (sequence xf) first)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (next-palindrome N))))
