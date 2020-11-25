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
    (map cache coll)))

(defn format-output
  "Print the output according to the task description"
  ([input products] (format-output true input products))
  ([stream input products]
   (let [swap-out (fn [i] (concat (subvec input 0 i) (subvec input (inc i))))]
     (cl-format stream "@M = (~{~a~^, ~})~%~%" products)
     (cl-format stream "~:{$M[~a] = ~{~a~^ x ~} = ~a~%~}"
                (map-indexed (fn [i v] [i (swap-out i) v]) products)))))

(defn -main
  "Run Task 1 with a list of numbers N, defaulting to the
  first example given in the task description."
  [& args]
  (let [N (or (some->> args (mapv edn/read-string)) [5 2 1 4 3])]
    (format-output N (array-of-product N))))
