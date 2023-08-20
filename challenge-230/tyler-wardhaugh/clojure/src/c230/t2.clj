(ns c230.t2
  (:require
    [clojure.edn :as edn]
    [clojure.string :as str]))

(def DEFAULT-INPUT ["at" ["pay" "attention" "practice" "attend"]])

(defn count-words
  [prefix coll]
  (->> coll
       (filter #(str/starts-with? % prefix))
       count))

(defn -main
  "Run Task 2 with a given inputs PREFIX and WORDS, defaulting to the first
  example from the task description."
  [& args]
  (let [[PREFIX WORDS] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (count-words PREFIX WORDS))))
