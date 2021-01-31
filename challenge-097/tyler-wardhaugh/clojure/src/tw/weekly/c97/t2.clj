(ns tw.weekly.c97.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Binary Substrings
;;;

(def DEFAULT-INPUT ["101100101" 3])

(defn binary-substrings
  [bstr size]
  (let [parts (partition size bstr)
        tranches (apply map vector parts)
        xf (comp
             (map (partial filter #{\0}))
             (map (juxt count #(- size (count %))))
             (map (partial apply min)))]
    (transduce xf + tranches)))

(defn -main
  "Run Task 2 using string B and size S, defaulting to the example given in
  the task description."
  [& args]
  (let [[B S] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (binary-substrings B S))))
