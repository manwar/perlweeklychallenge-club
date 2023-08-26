(ns c231.t2
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [["7868190130M7522" "5303914400F9211" "9273338290F4010"]])

(defn senior-citizens
  [coll]
  (->> coll
       (filter (fn [s]
                 (when-let [m (re-matches #"\d{10}\w(\d{2})\d{2}" s)]
                   (<= 60 (-> m second parse-long)))))
       count))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (senior-citizens COLL))))
