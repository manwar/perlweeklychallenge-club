(ns tw.weekly.c72.t2
  (:require [clojure.java.io :as io])
  (:require [clojure.edn :as edn])
  (:require [pjstadig.reducible-stream :refer [decode-lines!]]))

(defn lines-from
  "Produce a range of lines from a file"
  [file a b]
  (let [xf (comp (drop (dec a)) (take (- b a -1)))
        source (decode-lines! file)]
    (sequence xf source)))

(defn -main
  "Run Task 2 with a file and range of lines to print, defaulting to the first example in the task description"
  [& args]
  (let [file (or (some-> args first io/file) (io/resource "input.txt"))
        [a b] (or (some->> args (drop 1) (take 2) (map edn/read-string)) [4 12])]
    (dorun (map println (lines-from file a b)))))
