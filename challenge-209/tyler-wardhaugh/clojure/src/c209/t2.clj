(ns c209.t2
  (:require
    [clojure.edn :as edn]
    [clojure.set :as set]))

(def DEFAULT-INPUT [[["A" "a1@a.com" "a2@a.com"]
                     ["B" "b1@b.com"]
                     ["A" "a3@a.com" "a1@a.com"]]])

(defn merge-accounts
  [accounts]
  (->> accounts
       (group-by first)
       (mapcat (fn [[k vv]]
                 (let [sets (map (comp set rest) vv)]
                   (if (seq (apply set/intersection sets))
                     [(into [k] (sort (apply set/union sets)))]
                     vv))))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first
  example from the task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (prn (merge-accounts coll))))
