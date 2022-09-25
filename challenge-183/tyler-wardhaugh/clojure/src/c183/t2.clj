(ns c183.t2
  (:require [clojure.pprint :refer [cl-format]]
            [cljc.java-time.local-date :as ld]
            [cljc.java-time.temporal.chrono-unit :as cu]))

(def DEFAULT-INPUT ["2019-02-10" "2022-11-01"])

(defn date-diff
  [start end]
  (let [s (ld/parse start)
        e (ld/parse end)
        years (cu/between cu/years s e)
        days (cu/between cu/days (ld/plus-years s years) e)]
   [years days]))

(defn formatted-date-diff
  [start end]
  (let [[years days] (date-diff start end)
        fmt "~[~*~:;~:*~a year~:p~[~:; ~]~]~:*~[~:;~:*~a day~:p~]"]
    (cl-format nil fmt years days)))

(defn -main
  "Run Task 2 with a given input D1 and D2, defaulting to the first example
  from the task description."
  [& args]
  (let [[D1 D2] (or args DEFAULT-INPUT)]
    (print (formatted-date-diff D1 D2))))
