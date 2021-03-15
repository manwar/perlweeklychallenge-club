(ns tw.weekly.c98.t1
  (:import (java.io RandomAccessFile))
  (:require [clojure.edn :as edn]
            [clojure.java.io :as io]))

;;;
; Task description for TASK #1 › Read N-characters
;;;

(def DEFAULT-INPUT [(-> "input.txt" io/resource io/file) 4])
(def FILES (atom {}))

(defn readN
  "read n characters from file and move the pointer to the (n+1)th character"
  [file n]
  (let [rdr (get @FILES file (RandomAccessFile. file "r"))
        bytes (byte-array n)
        result (.read rdr bytes)]
    (when (pos? result)
        (swap! FILES assoc file rdr)
        (->> bytes
             (take-while pos?)
             (map char)
             (apply str)))))

(defn add-shutdown-hook!
  "Add a shutdown hook to ensure we close all our file readers."
  []
  (.addShutdownHook
    (Runtime/getRuntime)
    (Thread. (fn []
               (doseq [[_ rdr] @FILES]
                 (.close rdr))))))

(defn -main
  "Run Task 1 using a file F and size S, defaulting to the example
  given in the task description. Call readN on these values three times
  and print the result."
  [& args]
  (let [F (or (some-> args first io/file) (first DEFAULT-INPUT))
        S (or (some-> args second edn/read-string) (second DEFAULT-INPUT))]
    (add-shutdown-hook!)
    (dotimes [_ 3] (println (readN F S)))))
