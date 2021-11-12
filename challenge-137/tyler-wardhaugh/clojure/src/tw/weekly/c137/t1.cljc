(ns tw.weekly.c137.t1
  (:require [clojure.pprint :refer [cl-format]])
  #?(:bb (:import [])
     :clj (:import [java.time LocalDate]
                   [java.time.temporal WeekFields])))
;;;
; Task description for TASK #1 › Long Year
;;;

; define long-year-temporal?
#?(:bb
   (defn long-year-temporal? [_]
     (throw (Exception. "java.time.temporal not supported on Babashka")))

   :clj
   (let [week-of-year (.weekOfYear (WeekFields/ISO))]
     (defn long-year-temporal?
       "Is year long? (Uses Java's temporal library to get week number.)"
       [year]
       (-> (LocalDate/of year 12 28)
           (.get week-of-year)
           (= 53)))))

; define long-year-manual?
; source: https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
(let [p (fn [year]
          (-> (+ year
                 (quot year 4)
                 (* -1 (quot year 100))
                 (quot year 400))
              (mod 7)))]
  (defn long-year-manual?
    "Is year long? (Uses the method described in Wikipedia.)"
    [year]
    (or (= (p year) 4) (= (p (dec year)) 3))))

; choose an implementation based on our runtime (Clojure JVM or Babashka)
(def long-year? #?(:bb long-year-manual? :clj long-year-temporal?))

(defn -main
  "Run Task 1 with a given input M and N, defaulting to the first example from
  the task description."
  [& _]
  (cl-format true "~{~a~^, ~}~%" (filter long-year? (range 1900 2101))))
