(ns c200.t1
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[1 2 3 4]])

(defn arithmetic-slices
  [coll]
  (let [coll (vec coll)
        xf (comp (map (fn [[x y]] (- y x)))
                 (map-indexed vector)
                 (partition-by second)
                 (map #(map first %)))
        runs (->> coll (partition 2 1) (sequence xf))]
    (for [len (range 2 (count coll))
          run runs
          part (partition len 1 run)
          :let [s (first part)
                e (-> part last (+ 2))]]
      (subvec coll s e))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from
  the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)
        slices (arithmetic-slices coll)]
    (cl-format true "~[()~:;~{(~{~a~^,~})~^, ~}~]~%" (count slices) slices)))
