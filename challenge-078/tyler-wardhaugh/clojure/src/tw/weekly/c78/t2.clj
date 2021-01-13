(ns tw.weekly.c78.t2
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

;;; Task description for TASK #2 › Left Rotation
; You are given array @A containing positive numbers and @B containing one or
; more indices from the array @A.
;
; Write a script to left rotate @A so that the number at the first index of @B
; becomes the first element in the array. Similary, left rotate @A again so that
; the number at the second index of @B becomes the first element in the array.
;;;

; source: Nathan Rogers, https://groups.google.com/g/clojure/c/SjmevTjZPcQ/m/7_yNHfASAwAJ
(defn rotate
  "Perform a single rotation, where positive n rotates left and negative n rotates right"
  [n coll]
  (let [len (count coll)
        offset (mod (+ (mod n len) len) len)]
    (concat (drop offset coll) (take offset coll))))

(defn rotate-by-list
  "Rotate a collection by a list of rotations"
  [coll rotations]
  (->> rotations
       (reduce #(conj %1 (rotate %2 (first %1))) [coll])
       (drop 1)))

(defn -main
  "Run Task 2 with a list of numbers A and a list of rotations B, defaulting to the first example in the description"
  [& args]
  (let [A (or (some-> args first edn/read-string) [10 20 30 40 50])
        B (or (some-> args second edn/read-string) [3 4])
        solutions (rotate-by-list A B)]
    (cl-format true "~{[~{~a~^ ~}]~^~%~}" solutions)))
