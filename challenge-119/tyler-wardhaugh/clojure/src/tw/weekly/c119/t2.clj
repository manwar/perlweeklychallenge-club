(ns tw.weekly.c119.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Sequence without 1-on-1
;;;
(def DEFAULT-INPUT [5])

(defn seq-sans-1on1
  "Return the nth of the 'sequence without 1-on-1'"
  [n]
  (let [source (iterate inc 1)
        xf (comp 
             (map #(Long/toString % 4))
             (remove #(re-find #"(?:0|(?:11+))" %))
             (drop (dec n))
             (take 1))]
    (Long/parseLong (->> source (sequence xf) first))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (seq-sans-1on1 N))))
