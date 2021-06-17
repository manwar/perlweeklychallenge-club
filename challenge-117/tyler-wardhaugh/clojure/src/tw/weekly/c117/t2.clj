(ns tw.weekly.c117.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Find Possible Paths
;;;
(def DEFAULT-INPUT [2])

(defn- paths
  "Build up the results for all paths."
  [r l h n curr results]
  (if (= (+ r l) (+ r h) n)
    (conj results curr)
    (cond-> results
      (< (+ r l) n) (concat (paths (inc r) l h n (conj curr :R) results)
                            (paths r (inc l) h n (conj curr :L) results))
      (< h l) (concat (paths r l (inc h) n (conj curr :H) results)))))

(defn find-possible-paths
  "Find all possible paths from top to the bottom right corner."
  [n]
  (let [results (paths 0 0 0 n [] [])]
    (into
      (sorted-set)
      (map (fn [coll] (transduce (map name) str "" coll)))
      results)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~{~a~^ ~}~%" (find-possible-paths N))))
