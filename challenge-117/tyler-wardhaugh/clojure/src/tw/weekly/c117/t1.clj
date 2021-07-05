(ns tw.weekly.c117.t1
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.set :as set]
            [net.cgrand.xforms.io :as xio]))

;;;
; Task description for TASK #1 › Missing Row
;;;
(def DEFAULT-INPUT [(io/resource "input.txt")])
(def FIRST-ELEM 1)
(def LAST-ELEM 15)

(defn get-nums
  [file]
  (->> (xio/lines-in file)
       (into (sorted-set) (map edn/read-string))))

(defn missing-row-by-set-difference
  [file]
  (let [present (get-nums file)
        population (set (range FIRST-ELEM (inc LAST-ELEM)))
        missing (set/difference population present)]
    (first missing)))

(defn missing-row-by-incrementing
  [file]
  (let [present (conj (get-nums file)
                      (dec FIRST-ELEM)
                      (inc LAST-ELEM))]
    (->
      (fn [prev curr]
        (if (zero? (- curr prev 1))
          curr
          (reduced (dec curr))))
      (reduce present))))

(def missing-row missing-row-by-set-difference)

(defn -main
  "Run Task 1 with a given input FILE, defaulting to the first example from the
  task description."
  [& args]
  (let [[FILE] (or
                 (some->> args (map (comp io/file edn/read-string)))
                 DEFAULT-INPUT)]
    (println (missing-row FILE))))
