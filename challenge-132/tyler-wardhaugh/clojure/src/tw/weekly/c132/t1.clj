(ns tw.weekly.c132.t1
  (:require [java-time :as j]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Mirror Dates
;;;
(def DEFAULT-TODAY "2021/09/22")
(def DEFAULT-INPUT ["2021/09/18" DEFAULT-TODAY])
(def DATE-FORMAT "yyyy/MM/dd")

(defn parse-date
  [s]
  (j/local-date DATE-FORMAT s))

(defn format-date
  [d]
  (-> (j/formatter DATE-FORMAT)
      (j/format d)))

(defn mirror-date
  [origin today]
  (let [delta (j/time-between :days origin today)
        before (j/minus origin (j/days delta))
        after (j/plus today (j/days delta))]
    (list before after)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[origin today] (map parse-date (or args DEFAULT-INPUT))]
    (->> (mirror-date origin today)
         (map format-date)
         (cl-format true "~{~a~^, ~}~%"))))
