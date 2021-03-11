(ns tw.weekly.c103.t2
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.pprint :refer [cl-format]]
            [java-time :as j]
            [clojure.data.csv :as csv]))

;;;
; Task description for TASK #2 › What's playing?
;;;

(def DEFAULT-INPUT [1606134123 1614591276 (io/resource "stream.csv")])

(defn parse-csv
  "Parse the CSV file as specified in the task description, with two fields
  representing playtime and song title."
  [file]
  (with-open [reader (io/reader file)]
    (into []
          (map (fn [[track-time title]] [(Long/parseLong track-time) title]))
          (csv/read-csv reader))))

(defn currently-playing
  "Determine which song is currently playing."
  [start-time current-time filename]
  (let [source (parse-csv filename)
        playlist-duration (transduce (map first) + 0 source)
        pos (rem (* (- current-time start-time) 1000) playlist-duration)
        f (fn [pos [track-time title]]
            (let [new-pos (- pos track-time)]
              (if (pos? new-pos)
                new-pos
                (reduced [title pos]))))]
    (reduce f pos source)))

(defn -main
  "Run Task 2 with a start time, current timestamp, and data file defaulting
  to the example given in the task description."
  [& args]
  (let [[start-time current-time filename]
        (or (some->> args (take 3) (map edn/read-string)) DEFAULT-INPUT)
        [current-title current-position]
        (currently-playing start-time current-time filename)
        duration (j/duration current-position)
        [h m s] (map #(j/as duration %) [:hours :minutes :seconds])
        m (- m (* h 60))
        s (- s (* h 60) (* m 60))]
    (cl-format true "~s~%~2,'0d:~2,'0d:~2,'0d~%" current-title h m s)))
