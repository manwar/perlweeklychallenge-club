(ns tw.weekly.c118.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Binary Palindrom
;;;
(def DEFAULT-INPUT [5])

(defn binary-palindrome
  ""
  [n])

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (binary-palindrome N) 1 0))))
