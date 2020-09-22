(ns tw.weekly.c79.t2
  (:require [clojure.edn :as edn])
  (:require [oz.core :as oz]))

;;; Task description for TASK #2 › Trapped Rain Water
; You are given an array of positive numbers @N.
;
; Write a script to represent it as Histogram Chart and find out how much water it can trap.
;
; Example 1:
; Input: @N = (2, 1, 4, 1, 2, 5)
; The histogram representation of the given array is as below.
;      5           #
;      4     #     #
;      3     #     #
;      2 #   #   # #
;      1 # # # # # #
;      _ _ _ _ _ _ _
;        2 1 4 1 2 5
;;;

(defn splits
  "Partition the input by splitting it at each index, ensuring partitions contain at least one element."
  [coll]
  (map #(split-at % coll) (range 1 (dec (count coll)))))

(defn calculate-pools
  "Returns a sequence of pools, which are the amount of water 'units' that can be held at the inner elements of the coll, when viewed as a histogram."
  [coll]
  (let [neighboring-maxes (fn [[l [c & r]]] [(apply max l) c (apply max r)])
        to-water (fn [[l c r]] (max (- (min l r) c) 0))]
    (->> (splits coll)
         (eduction (map neighboring-maxes) (map to-water)))))

(defn capacity
  "Calculates the total capacity of the pools"
  [pools]
  (reduce + 0 pools))

(defn draw-histogram
  "Vizualize the histogram, using Oz (which uses Vega-Lite & Vega)"
  ([coll] (draw-histogram coll (calculate-pools coll)))
  ([coll pools] (let [make-hashes (fn [x land water] (list (hash-map :x x :y land :c "green") (hash-map :x x :y water :c "blue")))
                      values (mapcat make-hashes (range) coll (concat [0] pools [0]))]
                  (oz/view! {:data {:values values}
                             :encoding {:x {:field :x :type "ordinal"}
                                        :y {:field :y :type "quantitative" :aggregate "sum"}
                                        :color {:field :c
                                                :type "nominal"
                                                :scale nil}}
                             :mark "bar"}))))

(defn -main
  [& args]
  (let [N (or (some->> args (map edn/read-string)) [2 1 4 1 2 5])
        pools (calculate-pools N)]
    (println (capacity pools))
    (oz/start-server!)
    (draw-histogram N pools)))
