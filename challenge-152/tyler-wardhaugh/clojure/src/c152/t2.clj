(ns c152.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT ['[(-1,0), (2,2)] '[(0,-1), (4,4)]])
(def ZERO-RECT [[0 0] [0 0]])

(defn rectangle-area
  [r]
  (let [[[x1 y1] [x2 y2]] r]
    (* (abs (- x1 x2))
       (abs (- y1 y2)))))

(defn overlap
  [rs]
  (let [firsts (map first rs)
        seconds (map second rs)
        bottom-left (map (partial apply max) (apply map vector firsts))
        top-right (map (partial apply min) (apply map vector seconds))
        diff (apply min (map - top-right bottom-left))]
    (if (pos? diff) [bottom-left top-right] ZERO-RECT)))

(defn total-area
  [r1 r2]
  (let [both (transduce (map rectangle-area) + 0 [r1 r2])
        intersection (-> [r1 r2] overlap rectangle-area)]
    (- both intersection)))

(defn -main
  "Run Task 2 using rectangles R1 & R2, defaulting to the example given in the
  task description."
  [& args]
  (let [[R1 R2] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (total-area R1 R2))))
