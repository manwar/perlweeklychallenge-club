(ns tw.weekly.ch-2
  (:require [clojure.edn :as edn]))

; algorithm source: https://github.com/manwar/perlweeklychallenge-club/blob/master/challenge-075/simon-proctor/raku/ch-2.raku
;   Challenge answer by Simon Proctor
;   (modified from Raku)

(defn largest-rectangle-histogram
  "Compute the area of the largest possible rectangle within a histogram."
  [hist]
  (let [hist (vec hist)
        n (count hist)
        ranges (vec (for [x (range n), y (range n) :when (<= x y)]
                      [x y]))]
    (reduce (fn [ans [s e]]
              (let [height (apply min (map hist (range s (inc e))))
                    area (* height (inc (- e s)))]
                (max ans area)))
            0 ranges)))

(defn -main
  "Run Task 2 with a list of integers, defaulting to the sample given in the task description."
  [& args]
  (let [A (if (not-empty args) (map edn/read-string args) [2, 1, 4, 5, 3, 7])]
    (println (largest-rectangle-histogram A))))
