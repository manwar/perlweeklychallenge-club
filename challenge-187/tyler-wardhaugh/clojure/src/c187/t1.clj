(ns c187.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]
            [clojure.set :as set]
            [cljc.java-time.format.date-time-formatter :as dtf]
            [cljc.java-time.local-date :as ld]
            [cljc.java-time.month-day :as md]))

(def ^{:doc "A non-leap year to cast the dates in."} YEAR 1971)
(def ^{:doc "The format we expect dates in."} DATE-FMT (dtf/of-pattern "dd-MM"))

(def DEFAULT-INPUT
  [[{:name "Foo" :SD "12-01" :ED "20-01"}
    {:name "Bar" :SD "15-01" :ED "18-01"}]])

(defn ->date
  [s]
  (-> s (md/parse DATE-FMT) (md/at-year YEAR)))

(defn map->date-range
  [& {:keys [SD ED]}]
  (let [start (->date SD)
        end (->date ED)]
    (->> (iterate #(ld/plus-days % 1) start)
         (into #{} (take-while #(not (ld/is-after % end)))))))

(defn overlap
  [coll]
  (->> coll (map map->date-range) (apply set/intersection) count))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from
  the task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "~a day~:p" (overlap N))))
