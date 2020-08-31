(ns tw.weekly.ch-1
  (:require [clojure.edn :as edn])
  (:require [multiset.core :as ms]))

(declare memsolve)
(defn- solve
  "Recursively find solutions and return them in a list. This is the main worker function designed to be called only from find-coin-sum."
  [sum coins ci curr sols]
  (cond
    (= sum 0) (conj sols curr)
    (< sum 0) sols
    (and (< ci 0) (> sum 0)) sols
    :else (concat
            (memsolve sum coins (- ci 1) curr sols)
            (memsolve (- sum (get coins ci)) coins ci (conj curr (get coins ci)) sols))))

(def memsolve (memoize solve))

(defn find-coin-sum
  "Find the valid coin combinations to achieve the specified sum."
  [sum coins]
  (memsolve sum coins (- (count coins) 1) (ms/multiset) []))

(defn -main
  "Run Task 1 with a sum list of coin denominations, defaulting to the sample given in the task description."
  [& args]
  (let [[S C] (if (not-empty args)
                [(-> args first edn/read-string) (->> (rest args) (mapv edn/read-string))]
                [6 [1, 2, 4]])]
    (let [solutions (find-coin-sum S C)]
      (printf "There are %d possible way(s) to make sum %d using %s\n" (count solutions) S C)
      (println solutions))))
