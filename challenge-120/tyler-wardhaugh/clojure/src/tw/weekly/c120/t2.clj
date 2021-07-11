(ns tw.weekly.c120.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.math.numeric-tower :refer [abs]]))

;;;
; Task description for TASK #2 › Clock Angle
;;;
(def DEFAULT-INPUT ["03:10"])

(defn clock-angle
  "Find the smaller angle formed by the hands of an analog clock at a given
  time."
  [t]
  (let [[h m] (map #(Integer/parseInt %) (str/split t #":" 2))
        m-theta (* 6 m)
        h-theta (rem (+ (* h 30) (/ m-theta 12)) 360)
        abs-theta (abs (- m-theta h-theta))
        theta (if (<= abs-theta 180) abs-theta (- 360 abs-theta))]
    (str (with-precision 4 (bigdec theta)))))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[T] (or args DEFAULT-INPUT)]
    (println (clock-angle T))))
