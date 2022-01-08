(ns c146.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

; Clojure supports Ratios (including as literals)
(def DEFAULT-INPUT [3/5])

(defn parent
  [x]
  (when (not= x 1)
    (let [[n d] ((juxt numerator denominator) x)]
      (if (< x 1)
        (/ n (- d n))       ; left
        (/ (- n d) d)))))   ; right

(defn -main
  "Run Task 2 with a given input M, defaulting to the first example from the
  task description."
  [& args]
  (let [[M] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~{parent = '~a' and grandparent = '~a'~}~%"
               (->> M (iterate parent) (drop 1) (take 2)))))
