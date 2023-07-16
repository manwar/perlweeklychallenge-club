(ns c225.t1
  (:require
    [clojure.edn :as edn]
    [clojure.string :as str]))

(def DEFAULT-INPUT [["Perl and Raku belong to the same family."
                     "I love Perl."
                     "The Perl and Raku Conference."]])

(defn max-words
  [coll]
  (let [count-words (fn [s] (-> s (str/split #" ") count))]
    (transduce (map count-words) (completing #(apply max %&)) ##-Inf coll)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-words COLL))))
