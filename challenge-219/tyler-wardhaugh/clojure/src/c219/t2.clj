(ns c219.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [[2 7 25] [1 5 6 7 9 15]])

(defn travel-expenditure'
  [f costs days]
  (when (seq days)
    (let [source (zipmap [1 7 30] costs)
          xf (map (fn [[period cost]]
                    (let [[d & ds] days
                          candidates (drop-while #(< % (+ d period)) ds)]
                      (+ cost (f f costs candidates)))))]
      (->> source (sequence xf) (apply min)))))

(let [f (memoize travel-expenditure')]
  (defn travel-expenditure [costs days]
    (f f costs days)))

(defn -main
  "Run Task 1 with a given input COSTS and DAYS, defaulting to the first
  example from the task description."
  [& args]
  (let [[costs days] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (travel-expenditure costs days))))
