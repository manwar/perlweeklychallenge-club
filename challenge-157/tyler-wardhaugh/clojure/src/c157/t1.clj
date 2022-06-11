(ns c157.t1
  (:require [clojure.edn :as edn]
            [clojure.math :as m]
            [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[1,3,5,6,9]])

(defn am
  "Returns the arithmetic mean of coll"
  [coll]
  (/ (reduce + coll) (count coll)))

(defn gm
  "Returns the geometric mean of coll"
  [coll]
  (m/pow (reduce * coll) (/ (count coll))))

(defn hm
  "Returns the harmonic mean of coll"
  [coll]
  (/ (count coll) (transduce (map /) + coll)))

(def pythagorean-means (juxt am gm hm))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "AM = ~,1f, GM = ~,1f, HM = ~,1f" (am N) (gm N) (hm N))))
