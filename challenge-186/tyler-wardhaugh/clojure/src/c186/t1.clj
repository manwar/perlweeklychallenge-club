(ns c186.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [[1 2 3] ["a" "b" "c"]])

; "zip" is just the Clojure builtin interleave
(def zip interleave)

; include our own implementation
(defn zip'
  [a b]
  (sequence (comp (map vector) cat) a b))

(defn -main
  "Run Task 1 with a given input A and B, defaulting to the first example from
  the task description."
  [& args]
  (let [[A B] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (prn (zip A B))))
