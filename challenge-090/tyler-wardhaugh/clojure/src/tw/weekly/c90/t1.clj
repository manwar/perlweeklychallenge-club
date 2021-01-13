(ns tw.weekly.c90.t1
  (:require [clojure.string :as str])
  (:require [clojure.pprint :refer [cl-format]])
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › DNA Sequence
;;;

(def DEFAULT-DNA
  "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG")

(defn process-dna
  "Process the DNA sequence, counting nucleiobases and determining the
  complementary sequence."
  [dna]
  (let [complement-dna (fn [s] (str/escape s {\T \A, \A \T, \C \G, \G \C}))]
    ((juxt frequencies complement-dna) dna)))

(defn -main
  "Run Task 1 with a given DNA sequence, defaulting to the example given in
  the task description."
  [& args]
  (let [dna (or (some-> args first edn/read-string) DEFAULT-DNA)
        [freqs complement-seq] (process-dna dna)]
    (cl-format true "~12a: ~a~%~12a: ~a~%"
               "Counts" freqs
               "Complement" complement-seq)))
