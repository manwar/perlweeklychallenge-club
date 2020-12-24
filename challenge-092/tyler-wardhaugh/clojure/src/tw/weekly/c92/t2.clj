(ns tw.weekly.c92.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Insert Interval
;;;

(def DEFAULT-INPUT {:N [2 6] :S [[1 4], [8 10]]})

(defn insert-interval
  "Insert an interval `n` into a sorted sequence of non-overlapping intervals `s`."
  [n s]
  (let [[n1 n2] n
        get-head (fn [coll] (ffirst coll))
        get-tail (fn [coll] (-> coll last second))]
    (cond (< n2 (get-head s)) (concat [n] s)
          (> n1 (get-tail s)) (concat s [n])
          :else
          (let [xf (map (fn [[c1 c2 :as c]] [c (<= n1 c2) (>= n2 c1)]))
                step1 (eduction xf s)
                just-h (keep (fn [[c x _]] (when x c)))
                just-t (keep (fn [[c _ y]] (when y c)))
                leading (keep (fn [[c x y]] (when (and (not x) y) c)))
                lagging (keep (fn [[c x y]] (when (and x (not y)) c)))
                head (min n1 (get-head (sequence just-h step1)))
                tail (max n2 (get-tail (sequence just-t step1)))]
            (concat (sequence leading step1)
                    [[head tail]]
                    (sequence lagging step1))))))

(defn -main
  "Run Task 2 with the given positive integers, defaulting to the example
  given in the explanation page linked from the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string vec) (:N DEFAULT-INPUT))
        S (or (some->> args second edn/read-string) (:S DEFAULT-INPUT))]
    (cl-format true "~{(~{~a~^,~})~^, ~}~%" (insert-interval N S))))
