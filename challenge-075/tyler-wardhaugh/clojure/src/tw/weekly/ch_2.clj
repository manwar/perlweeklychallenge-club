(ns tw.weekly.ch-2
  (:require [clojure.edn :as edn]))

; algorithm source: https://stackoverflow.com/a/35931960
;   Answer by Spectral (https://stackoverflow.com/users/2558887/spectral)
;   (modified from Python)

(defn largest-rectangle-histogram
  "Compute the area of the largest possible rectangle within a histogram."
  [hist]
  (let [decorated (into [] (concat [-1] hist [-1]))
         stack (atom (list [0 (first decorated)]))
         max-area (atom 0)]
     (reduce-kv (fn [ans k v]
                  (while (< v (-> @stack peek last))
                    (let [head (-> (swap-vals! stack pop) first peek last)
                          area (* head (- k (-> @stack peek first) 1))]
                      (swap! max-area max area)))
                  (swap! stack conj [k v])
                  (max ans @max-area))
                0 decorated)))

(defn -main
  "Run Task 2 with a list of integers, defaulting to the sample given in the task description."
  [& args]
  (let [A (if (not-empty args) (map edn/read-string args) [2, 1, 4, 5, 3, 7])]
    (prn (largest-rectangle-histogram A))))
