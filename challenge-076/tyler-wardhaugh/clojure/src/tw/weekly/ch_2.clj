(ns tw.weekly.ch-2
  (:require [clojure.java.io :as io])
  (:require [clojure.string :as str])
  (:require [clojure.core.matrix :as mat]))

(def min-word-length 5)

(defn parse-grid-file
  "Parse grid file and return a multidimensional vector of chars."
  [grid-file]
  (with-open [rdr (io/reader grid-file)]
    (-> rdr
        line-seq
        seq
        (->> (map #(remove (fn [c] (Character/isWhitespace c)) %)))
        to-array-2d)))

(defn parse-dict-file
  "Parse dictionary and return a vector of words."
  [dict-file]
  (with-open [rdr (io/reader dict-file)]
    (->> (line-seq rdr)
         (filter #(>= (count %) min-word-length))
         (map str/trim-newline)
         (map str/upper-case)
         (into []))))

(defn build-lines
  "Return a set of lines in a word grid that could contain valid words."
  [grid]
  (let [[m n] (mat/shape grid)
        transposed (mat/transpose grid)
        rotated (mapv #(vec (reverse (mat/get-row transposed %))) (range n))
        get-diags (fn [g d] (map #(mat/diagonal g %) (range (- d) d)))
        diag-across (get-diags grid m)
        diag-down (get-diags rotated n)]
    (->> [grid transposed diag-across diag-down]
         (mapcat #(into [] (comp (map str/join) (remove (partial = ""))) %))
         (mapcat (juxt identity str/reverse))
         (into #{}))))

(defn word-search
  "Return a sequence of words found in a grid from a dictionary."
  [grid dict]
  (let [all-lines (build-lines grid)]
    (->> dict
         (mapcat (fn [word] (keep #(when (str/includes? % word) word) all-lines))))))

(defn -main
  "Run Task 2 with a grid file and a dictionary file, defaulting to the ones in the resources directory."
  [& args]
  (let [grid-file (or (some-> args first io/file) (io/resource "grid.txt"))
        dict-file (or (some-> args second io/file) (io/resource "dict.txt"))
        grid (parse-grid-file grid-file)
        dict (parse-dict-file dict-file)
        words (word-search grid dict)]
    (printf "%d word(s) from the dictionary of %d word(s) found in the grid:\n" (count words) (count dict))
    (doseq [word words] (println word))))
