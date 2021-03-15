(ns tw.weekly.c95.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › Palindrome Number
;;;

(def DEFAULT-INPUT 1221)

(defn palindrome-number?'
  "Tests whether `n` is a palindrome number. The easy way."
  [n]
  (let [nstr (str n)]
    (= nstr (str/reverse nstr))))

(defn palindrome-number?
  "Tests whether `n` is a palindrome number. A more sophisticated method
  than the above."
  [n]
  (let [nstr (str n)
        len (count nstr)
        mid (quot len 2)]
    (loop [i 0
           j (dec len)]
      (cond
        (< j mid i) true
        (not= (.charAt nstr i) (.charAt nstr j)) false
        :else (recur (inc i) (dec j))))))

(defn -main
  "Run Task 1 using an array of strings S, defaulting to the example given in
  the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (if (palindrome-number? N) 1 0))))
