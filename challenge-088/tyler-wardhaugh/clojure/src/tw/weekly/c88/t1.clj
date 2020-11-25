(ns tw.weekly.c88.t1
  (:require [clojure.edn :as edn])
  (:require [clojure.math.numeric-tower :as math])
  (:require [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Array of Product
;;;

(defn array-of-product
  "Return an array @M where $M[i] is the product of all elements of @N except the index $N[i]."
  [coll]
  (let [freqs (frequencies coll)
        product (transduce (map (partial apply math/expt)) * freqs)
        cache-xf (map (juxt key (comp (partial / product) key)))
        cache (into {} cache-xf freqs)]
  (sequence (map cache) coll)))

(defn -main
  "Run Task 1 with a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [N (or (some->> args (map edn/read-string)) [5 2 1 4 3])]
    (cl-format true "@M = (~{~a~^, ~})" (array-of-product N))))
