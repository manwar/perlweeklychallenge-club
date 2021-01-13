(ns tw.weekly.c83.t1
  (:require [clojure.string :as str]))

;;; Task description for TASK #1 › Words Length
; Submitted by: Mohammad S Anwar
; You are given a string $S with 3 or more words.
;
; Write a script to find the length of the string except the first and last words ignoring whitespace.
;
; Example 1:
; Input: $S = "The Weekly Challenge"
; Output: 6
;
;
; Example 2:
; Input: $S = "The purpose of our lives is to be happy"
; Output: 23
;
;;;

(defn inner-words-length
  "Return the combined length of the inner words, ignoring whitespace."
  [s]
  (let [source (->> (str/split s #" ") (drop 1) (drop-last 1))]
    (transduce (map count) + source)))

(defn -main
  "Run Task 1 with a strings S, defaulting to the first example given in the task description."
  [& args]
  (let [S (or (some-> args first) "The Weekly Challenge")
        len (inner-words-length S)]
    (println len)))
