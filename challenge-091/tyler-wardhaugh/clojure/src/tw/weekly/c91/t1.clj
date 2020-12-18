(ns tw.weekly.c91.t1
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Count Number
;;;

(def DEFAULT-INPUT 1122234)

(defn count-number
  "Produce a simple run-level encoding for a positive integer."
  [n]
  (let [xf (mapcat (juxt count first))]
    (edn/read-string (transduce xf str (->> n str (partition-by identity))))))

(defn -main
  "Run Task 1 using a given integer, defaulting to the example given in
  the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)
        result (count-number N)]
    (println result)
    (cl-format true "~%as we read ~{~{~r ~a~}~^ ~}~%"
               (->> (str result)
                    (partition 2)
                    (map (fn [[c v]] [(Integer/parseInt (str c)) v]))))))
