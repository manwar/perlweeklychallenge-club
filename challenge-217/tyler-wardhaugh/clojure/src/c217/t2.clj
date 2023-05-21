(ns c217.t2
  (:require
    [clojure.edn :as edn]
    [clojure.string :as str]))

(def DEFAULT-INPUT [[1 23]])

(defn max-number
  [coll]
  (let [cmp (fn [a b] (compare (str b a) (str a b)))]
      (->> coll (sort cmp) str/join parse-long)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (max-number coll))))
