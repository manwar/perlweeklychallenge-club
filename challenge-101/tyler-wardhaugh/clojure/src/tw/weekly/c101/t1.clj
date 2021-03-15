(ns tw.weekly.c101.t1
  (:require [clojure.edn :as edn]
            [clojure.core.matrix :as m]
            [clojure.math.numeric-tower :as math]
            [tw.weekly.util.matrix :as um]))

;;;
; Task description for TASK #1 › Pack a Spiral
;;;

(def DEFAULT-INPUT [1 2 3 4])

(defn get-min-size
  "Determine the minimum shape necessary for a matrix to hold len items."
  [len]
  (let [source (range 1 (inc (quot len 2)))
        xf (comp
             (filter #(zero? (mod len %1)))
             (map (juxt #(math/abs (- % (quot len %))) identity)))
        f (partial min-key first)]
    (->> source
         (transduce xf (completing f) [len len])
         second
         ((juxt identity (partial quot len))))))

(defn- pack
  "Recursively pack an incoming coll into an m x n spiral matrix. This is a
  helper function for pack-spiral, not meant to be called directly."
  [coll m n]
  (condp = 1
    m (vector coll)
    n (map vector (reverse coll))
    (m/join (um/rotate-matrix (pack (drop n coll) n (dec m)))
            (vector (take n coll)))))

(defn pack-spiral
  "Return coll as a packed spiral matrix."
  [coll]
  (let [[m n] (get-min-size (count coll))]
    (m/matrix (pack coll m n))))

(defn -main
  "Run Task 1 using a list A, defaulting to the example given in the task
  description."
  [& args]
  (let [A (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (um/print-matrix (pack-spiral A))))
