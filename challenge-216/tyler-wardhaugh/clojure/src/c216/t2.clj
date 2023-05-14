(ns c216.t2
  (:require
    [clojure.edn :as edn]
    [clojure.set :as set]))

(def DEFAULT-INPUT ["peon" ["perl" "raku" "python"]])

(defn dict-weight
  [dict]
  (reduce + 0 (vals dict)))

(defn dict-common-keys
  [a b]
  (set/intersection (set (keys a)) (set (keys b))))

(defn dict-left-keys
  [a b]
  (select-keys b (dict-common-keys a b)))

(defn dict-intersect
  [a b]
  (let [common-b (dict-left-keys a b)
        before (+ (dict-weight a) (dict-weight common-b))
        after (dict-weight (merge-with - a common-b))]
    [(- before after) common-b]))

(defn dict-minus
  [a b]
  (->> (dict-left-keys a b)
       (merge-with - a)
       (into {} (filter (fn [[_ v]] (pos? v))))))

(defn word-stickers
  [word coll]
  (if (seq (set/difference (set word) (transduce (map set) set/union coll)))
    0
    (let [counts (into [] (map frequencies) coll)
          letters (frequencies word)]
      (loop [letters letters
             result 0]
        (if (empty? letters)
          result
          (let [best (->> counts
                          (map #(dict-intersect letters %))
                          (apply max-key first)
                          second)]
            (recur (dict-minus letters best) (inc result))))))))

(defn -main
  "Run Task 2 with a given input WORD & COLL, defaulting to the first example
  from the task description."
  [& args]
  (let [[word coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (word-stickers word coll))))
