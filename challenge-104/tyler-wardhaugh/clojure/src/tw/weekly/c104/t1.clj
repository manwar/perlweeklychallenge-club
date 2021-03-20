(ns tw.weekly.c104.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › FUSC Sequence
;;;
(def DEFAULT-INPUT 50)

(defn fusc
  "Generate FUSC sequence for 0..n"
  [n]
  (let [init [0 1]
        f (fn [acc n]
            (conj acc
                  (if (even? n)
                    (nth acc (/ n 2))
                    (+ (nth acc (/ (dec n) 2)) (nth acc (/ (inc n) 2))))))]
    (take (inc n) (reduce f init (range 2 n)))))

(defn -main
  "Run Task 1 with a given N, defaulting to the example given in the task
  description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "~{~a~^ ~}~%" (fusc N))))
