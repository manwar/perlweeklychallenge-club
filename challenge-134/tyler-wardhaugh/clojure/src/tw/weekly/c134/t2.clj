(ns tw.weekly.c134.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.pprint :refer [cl-format print-table]]))

;;;
; Task description for TASK #2 › Distinct Terms Count
;;;
(def DEFAULT-INPUT [3 3])

;;;
; Clojure provides a built in pretty printer for tables, which is similar to
; the output requested in the challenge, so let's use that and modify it as
; necessary.
;
; First we transform the input into what the pretty printer expects by
; converting a table (list-of-lists) to a list of sorted maps where the key is
; the index and value is unchanged, after prepending each with the inner list
; count (starting from 1). After feeding that into the printer, we capture it
; and modify it to our needs.
;;;
(defn table-str
  "Return a pretty-printable representation of table."
  [table]
  (let [xf (map-indexed
             (fn [i v] (into (sorted-map)
                             (map-indexed vector)
                             (conj (seq v) (inc i)))))]
    (-> (with-out-str (print-table (sequence xf table)))
        (str/replace-first \0 \x)
        (str/replace #"(?m)(^\||\|$)" " ")
        (str/replace #"(?<=\+.*)\+" "-")
        (str/replace #"(?<=\|.*)\|" " "))))

(defn gen-mult-table
  "Return a vector of [table distinct-terms], where table is a list-of-lists
  representing the multiplication table of MxN and distinct-terms is a set of
  all the terms in said table."
  [M N]
  (let [base (for [m (range M), n (range N)] (* (inc m) (inc n)))]
    (vector (partition N base) (set base))))

(defn -main
  "Run Task 1 with a given input M and N, defaulting to the first example from
  the task description."
  [& args]
  (let [[M N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)
        [table distinct-terms] (gen-mult-table M N)]
    (cl-format true "~a~%Distinct Terms: ~{~a~^, ~}~%Count: ~a~%"
               (table-str table)
               (sort distinct-terms)
               (count distinct-terms))))
