(ns tw.weekly.c81.t2
  (:require [clojure.java.io :as io])
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.string :as str])
  (:require [net.cgrand.xforms :as x])
  (:require [net.cgrand.xforms.io :as xio]))

;;; Task description for TASK #2 › Frequency Sort
; You are given file named input.
;
; Write a script to find the frequency of all the words.
;
; It should print the result as first column of each line should be the frequency of the the word followed by all the words of that frequency arranged in lexicographical order. Also sort the words in the ascending order of frequency.
;;;

(defn word-frequency-sort
  "Return a sorted word frequency map for a given text."
  [source]
  (let [cleaner (fn [s] (str/replace s #"(?:[.\"\(\),]|'s|--|\n)" " "))
        splitter (fn [s] (str/split s #" "))
        xf (comp (mapcat (comp splitter cleaner))                 ; wordify
                 (remove #{""})                                   ; discard empty strings
                 (x/by-key identity (constantly 1) (x/reduce +))  ; hash (word => count)
                 (x/by-key second first (x/into (sorted-set))))]  ; invert hash, combine words
    (into (sorted-map) xf source)))

(defn -main
  "Run Task 2 with an input, defaulting to the example given in the task description."
  [& args]
  (let [input (or (some->> args first io/file) (io/resource "input"))
        freqs (word-frequency-sort (xio/lines-in input))]
    (cl-format true "~:{~a ~{~a~^ ~}~%~^~%~}" freqs)))
