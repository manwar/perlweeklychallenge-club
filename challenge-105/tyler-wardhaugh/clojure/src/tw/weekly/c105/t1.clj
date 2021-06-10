(ns tw.weekly.c105.t1
  (:require [clojure.edn :as edn]
            [clojure.math.numeric-tower :as math]
            [clojure.pprint :refer [cl-format]])
  (:import [org.apache.commons.math3.complex Complex]))

;;;
; Task description for TASK #1 › Nth root
;;;
(def DEFAULT-INPUT [5 248832])

(defn nth-root
  "The nth-root function, using Clojure's numeric tower"
  [n k]
  (math/expt k (/ n)))

(defn nth-roots-complex
  "The nth-root function, using Apache Commons Math library. Returns a list of
  nth roots, which includes complex numbers"
  [n k]
  (-> k (Complex.) (.nthRoot n)))

(defn -main
  "Run Task 1 with a given N, defaulting to the example given in the task
  description."
  [& args]
  (let [[N K] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "Nth root:~%~:{~20@:a: ~{~a~^; ~}~%~}~%"
               [["numeric-tower" (list (nth-root N K))]
                ["Apache Commons" (map #(.toString %) (nth-roots-complex N K))]])))
