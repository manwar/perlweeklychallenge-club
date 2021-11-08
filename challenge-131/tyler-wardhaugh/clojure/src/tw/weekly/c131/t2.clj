(ns tw.weekly.c131.t2
  (:require [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2, Find Pairs
;;;
(def DEFAULT-INPUT ["\"\"[]()" "\"I like (parens) and the Apple ][+\" they said."])

(defn re-quote-set
  "Turn a sequence of characters (either a string or a collection) into a regex
  matching that set."
  [coll]
  (re-pattern (cl-format nil "[\\Q~{~a~}\\E]" coll)))

(defn split-alternate
  "Split a collection into two collections by alternating the elements."
  [coll]
  (-> (fn [[a b] i v] (if (even? i) [(conj a v) b] [a (conj b v)]))
      (reduce-kv [[] []] (vec coll))))

(defn- find-pairs-by
  "Base function for find-pairs-by-* functions."
  [xf delimiter-pairs]
  (->> (split-alternate delimiter-pairs)
       (eduction xf (map #(reduce str "" %)))))

(defn find-pairs-by-regex
  "Find delimiter pairs in search-string, returning two sequences of the
  opening and closing delimiters. Uses regex matching."
  [delimiter-pairs search-string]
  (let [xf (map #(re-seq (re-quote-set %) search-string))]
    (find-pairs-by xf delimiter-pairs)))

(defn find-pairs-by-char
  "Find delimiter pairs in search-string, returning two sequences of the
  opening and closing delimiters. Uses filtering by character."
  [delimiter-pairs search-string]
  (let [xf (map #(filter (set %) search-string))]
    (find-pairs-by xf delimiter-pairs)))

(def find-pairs find-pairs-by-char)

(defn -main
  "Run Task 1 with a given input D and S, defaulting to the first example from
  the task description."
  [& args]
  (let [[D S] (or args DEFAULT-INPUT)]
    (cl-format true "~{~a~%~}" (find-pairs D S))))
