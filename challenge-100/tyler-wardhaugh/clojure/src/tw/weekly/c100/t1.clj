(ns tw.weekly.c100.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [java-time :as j]))

;;;
; Task description for TASK #1 › Fun Time
;;;

(def DEFAULT-INPUT "05:15pm")

(def FMT-12H "hh:mma")
(def FMT-24H "HH:mm")
(def TIME-MATCHER (re-pattern #"(?i)\s*(\d{1,2}:\d{1,2})\s*([ap]\.?m\.?)?\s*"))

(defn fun-time
  "Convert the given time in string s from 12 hour format to 24 hour format
  and vice versa."
  [s]
  (let [[match hhmm ampm] (re-matches TIME-MATCHER s)]
    (when match
      (let [[parser timestr fmt]
            (if ampm
              [FMT-12H (str hhmm (str/upper-case ampm)) FMT-24H]
              [FMT-24H hhmm FMT-12H])
            time (j/local-time parser timestr)]
        (j/format fmt time)))))

(defn -main
  "Run Task 1 using a string T representing a 12h or 24h time, defaulting to the example
  given in the task description."
  [& args]
  (let [T (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (fun-time T))))
