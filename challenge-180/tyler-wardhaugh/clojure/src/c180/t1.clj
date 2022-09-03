(ns c180.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT ["Perl Weekly Challenge"])

(defn first-unique-char
  [s]
  (let [freq (frequencies s)]
    (->> s (keep-indexed (fn [i v] (when (= 1 (freq v)) i))) first)))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or args DEFAULT-INPUT)]
    (println (first-unique-char N))))
