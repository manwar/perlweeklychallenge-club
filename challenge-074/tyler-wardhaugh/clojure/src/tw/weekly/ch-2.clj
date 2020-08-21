(ns tw.weekly.ch-2
  (:require [clojure.string :as str])
  (:require [flatland.ordered.map :as fo]))

(defn ordered-frequencies
  "A modification of clojure.core/frequencies that guarantees the map returns keys in the order seen in the collection. Thus it returns an ordered map from distinct items in coll to the number of times they appear."
  [coll]
  (persistent!
   (reduce (fn [counts x]
             (assoc! counts x (inc (get counts x 0))))
           (transient (fo/ordered-map)) coll)))

(defn find-fnr [string]
  "Find the first non-repeating character (FNR) for a string."
  (let [counts (ordered-frequencies string)
        non-repeaters (filter (comp #(= 1 %) second) counts)]
    (-> non-repeaters last first)))

(defn find-fnr-over-string
  "Generate a string comprised of the first non-repeating character (FNR) for successive substrings of a given string."
  [string]
  (->> string
       (reductions str "")
       (drop 1)
       (map find-fnr)
       (map #(or % \#))
       str/join))

(defn -main
  "Run Task 2 with a string, defaulting to the sample given in the task description."
  [& args]
  (let [S (or (-> args first) "ababc")]
    (println (find-fnr-over-string S))))
