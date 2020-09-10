(ns tw.weekly.ch-1
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn])
  (:require [net.cgrand.xforms :as x]))

; source: https://github.com/cgrand/xforms
(defn sliding-min
  "A transducer to calculate the min of a sliding window over a sequence."
  [size]
  (comp (x/window size
                  (fn
                    ([] (sorted-map))
                    ([m] (key (first m)))
                    ([m x] (update m x (fnil inc 0))))
                  (fn [m x]
                    (let [n (dec (m x))]
                      (if (zero? n)
                        (dissoc m x)
                        (assoc m x (dec n))))))
        (drop (dec size))))

(defn -main
  "Run Task 1 with a size (S) and a list of integers (A), defaulting to the example given in the task description."
  [& args]
  (let [S (or (some-> args first edn/read-string) 3)
        A (or (some->> args rest (map edn/read-string)) [1 5 0 2 9 3 7 6 4 8])]
    (cl-format true "~10a: (~{~a~^ ~}), size = ~d~%~10a: (~{~a~^ ~})~%"
               "Input" A S
               "Output" (sequence (sliding-min 3) A))))
