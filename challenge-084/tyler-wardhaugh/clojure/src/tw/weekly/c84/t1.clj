(ns tw.weekly.c84.t1
  (:require [clojure.edn :as edn])
  (:require [clojure.string :as str]))

;;; Task description for TASK #1 › Reverse Integer
;
; You are given an integer $N.
;
; Write a script to reverse the given integer and print the result. Print 0 if the result doesn’t fit in 32-bit signed integer.
;
; The number 2,147,483,647 is the maximum positive value for a 32-bit signed binary integer in computing.
;
; Example 1:
; Input: 1234
; Output: 4321
;
; Example 2:
; Input: -1234
; Output: -4321
;
; Example 3:
; Input: 1231230512
; Output: 0
;
;;;

(defn reverse-int
  "Reverse an integer"
  [n]
  (let [abs #(Math/abs %)
        parse-int #(Integer/parseInt %)
        restore-sign #(* (Integer/signum n) %)]
    (try
      (-> n int abs str str/reverse parse-int restore-sign)
      (catch Exception _ 0))))

(defn -main
  "Run Task 1 with an integer N, defaulting to the first example given in the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) 1234)]
    (println (reverse-int N))))
