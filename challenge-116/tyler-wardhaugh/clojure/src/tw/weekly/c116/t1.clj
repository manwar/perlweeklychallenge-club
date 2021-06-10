(ns tw.weekly.c116.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Number Sequence
;;;
(def DEFAULT-INPUT [1234])
(def NORESULT-FMT "~a as it is impossible to split satisfying the conditions.")

(defn seq-to-int
  [coll]
  (->> coll (reduce str "") (#(Integer/parseInt %))))

(defn -number-sequence
  [n]
  (let [nseq (-> n str seq)
        nlen (count nseq)]
    (->> (range 1 (quot nlen 2))
         (keep (fn [len]
                 (let [start (->> nseq (take len) seq-to-int)]
                   (reduce
                     (fn [acc end]
                       (let [accint (seq-to-int acc)]
                         (if (>= (-> accint str count) nlen)
                           (reduced [accint start end])
                           (conj acc end))))
                     [start]
                     (iterate inc (inc start))))))
         (keep (fn [[n-candidate start end]]
                 (when (= n-candidate n) [start end])))
         first)))

(defn number-sequence
  "Treating the number as a string, split the number into elements such that
  the difference is 1 and each element > 0 (and no leading zeros are used)"
  [n]
  (if-let [[start end] (-number-sequence n)]
    (cl-format nil "~{~a~^,~}" (range start end))
    (cl-format nil NORESULT-FMT n)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (number-sequence N))))
