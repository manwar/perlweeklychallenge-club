(ns tw.weekly.c118.t2
  (:require [clojure.core.matrix :as m]
            [clojure.edn :as edn]
            [clojure.java.io :as io]
            [clojure.math.combinatorics :as combo]
            [clojure.pprint :refer [cl-format]]
            [clojure.string :as str]
            [loom.alg :as la]
            [loom.graph :as lg]))

;;;
; Task description for TASK #2 › Adventure of Knight
;;;
(def DEFAULT-INPUT [(io/resource "input.txt")])
(def SIZE 8)
(def LEGEND {\* 0, \x 1, \N 2})

(defn parse-matrix
  "Parse a matrix file and return a matrix"
  [matrix-file]
  (with-open [in (io/reader matrix-file)]
    (let [xf (map (comp
                    edn/read-string
                    #(str \[ % \])
                    #(str/escape % LEGEND)))]
      (into [] xf (line-seq in)))))

(def NOTATED-BOARD
  (->> (for [row (range SIZE 0 -1)
             col "abcdefgh"]
         (str col row))
       (partition SIZE)
       to-array-2d))

(defn coord->notation
  [[x y]]
  (aget NOTATED-BOARD x y))

(defn find-indexes-of-vals
  [board val]
  (let [xf (comp cat (keep identity))
        source (m/emap-indexed (fn [[x y] v] (when (= v val) [x y])) board)]
   (sequence xf source)))

; cf. https://en.wikipedia.org/wiki/Night_Moves_(Bob_Seger_song)
(defn knight-moves
  [x y size]
  (let [source [[1 2] [-1 2] [2 1] [2 -1]]
        xf (comp (map (fn [[dx dy]] [(+ x dx) (+ y dy)]))
                 (filter (fn [[x y]] (and (<= 0 x (dec size))
                                          (<= 0 y (dec size))))))]
    (sequence xf source)))

(defn build-knights-graph
  "Build a Knight's graph (see https://en.wikipedia.org/wiki/Knight%27s_graph)."
  [size]
  (let [rng (range size)
        source (combo/cartesian-product rng rng)
        xf (map (fn [[x y]] [[x y] (knight-moves x y size)]))]
    (->> source
         (into {} xf)
         lg/weighted-graph)))

(defn build-treasure-graph
  [g board start]
  (let [treasures (find-indexes-of-vals board (LEGEND \x))
        source (concat
                 (map (fn [end] [start end]) treasures)
                 (combo/cartesian-product treasures treasures))
        xf (comp
             (filter (fn [[n1 n2]] (not= n1 n2)))
             (map (fn [[n1 n2]] [n1 n2 (count (la/dijkstra-path g n1 n2))])))
        paths (sequence xf source)]
    (apply lg/weighted-digraph paths)))

(defn hamiltonian
  [g start knights-graph]
  (let [nodes (remove #{start} (lg/nodes g))
        source (combo/permutations nodes)
        xf (map (fn [arrangement]
                  (reduce
                    (fn [[path len] v]
                      (let [dist (lg/weight g (peek path) v)
                            pp (la/dijkstra-path knights-graph (peek path) v)]
                        [(into path (rest pp)) (+ len dist)]))
                    [[start] 0]
                    arrangement)))
        f (fn [[min-path min-len] [path len]]
            (if (< len min-len)
              [path len]
              [min-path min-len]))]
    (-> (transduce xf (completing f) [[] ##Inf] source)
        first)))

(defn adventure-of-knight
  [board]
  (let [start (first (find-indexes-of-vals board (LEGEND \N)))
        knights-graph (build-knights-graph SIZE)
        treasure-map (build-treasure-graph knights-graph board start)
        min-path (hamiltonian treasure-map start knights-graph)]
    (map coord->notation min-path)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[FILE] (or (some->> args (map (comp io/file edn/read-string)))
                   DEFAULT-INPUT)
        board (-> FILE parse-matrix m/matrix)
        adventure (adventure-of-knight board)]
    (cl-format true "~{~a~^, ~}~%" adventure)))
