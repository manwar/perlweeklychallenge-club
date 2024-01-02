(ns c250.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [["perl", "2", "000", "python", "r4ku"]])

(defn alphanumeric-string
  [coll]
  (let [xf (map (fn [s-or-int]
                  (if-let [i (parse-long s-or-int)]
                    i
                    (count s-or-int))))
        f (completing (fn [w v] (max w v)))]
    (transduce xf f ##-Inf coll)))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (alphanumeric-string COLL))))
