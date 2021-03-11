(ns tw.weekly.c103.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.data.finger-tree :as ft]
            [clojure.pprint :refer [cl-format]])
  (:import (java.util Locale)
           (net.time4j.calendar ChineseCalendar)
           (net.time4j PlainDate)))

;;;
; Task description for TASK #1 › Chinese Zodiac
;;;
(def DEFAULT-INPUT 2017)

;; A counted-double-list is a type of finger tree that provides:
;;    O(n) left/right access
;;    O(n) count
;;    O(log n) nth
(def ANIMALS (into ft/empty-counted-double-list
                   ["Rat" "Ox" "Tiger" "Rabbit" "Dragon" "Snake" "Horse" "Goat"
                    "Monkey" "Rooster" "Dog" "Pig"]))
(def ELEMENTS (into ft/empty-counted-double-list
                    ["Wood" "Fire" "Earth" "Metal" "Water"]))

; First "Wood Rat" year in CE
(def BASE-YEAR 4)

(defn chinese-zodiac-simple
  "Determine the Chinese Zodiac name for the given year, using a
  simple, but slightly naïve algorithm."
  [year]
  (let [indexes ((juxt #(mod (quot % 2) (count ELEMENTS))
                       #(mod % (count ANIMALS)))
                 (- year BASE-YEAR))
        [element animal] (map #(apply nth %&) [ELEMENTS ANIMALS] indexes)]
    (str element " " animal)))

(defn chinese-zodiac-time4j
  "Determine the Chinese Zodiac name for the given year, using a
  library."
  [year]
  (let [cyear (-> (PlainDate/of year 12 31)
                  (.transform (ChineseCalendar/axis))
                  (.getYear))
        element (-> (.name (.getStem cyear))
                    (str/split #"_")
                    (nth 2)
                    str/capitalize)
        animal (.getZodiac cyear Locale/ENGLISH)]
    (str element " " animal)))

(defn -main
  "Run Task 1 using a YEAR, defaulting to the example given in the task
  description."
  [& args]
  (let [YEAR (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "Zodiac:~%~:{~10@a: ~a~%~}"
               [["Simple" (chinese-zodiac-simple YEAR)]
                ["Time4J" (chinese-zodiac-time4j YEAR)]])))
