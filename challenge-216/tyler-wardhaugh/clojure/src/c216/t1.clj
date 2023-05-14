(ns c216.t1
  (:require
    [clojure.edn :as edn]
    [clojure.set :as set]
    [clojure.string :as str]))

(def DEFAULT-INPUT ["AB1 2CD" ["abc" "abcd" "bcd"]])

(defn registration-number
  [reg coll]
  (let [clean-reg (into #{}
                        (comp
                          (filter #(Character/isLetter %))
                          (map (comp first str/lower-case)))
                        reg)]
    (filter #(set/subset? clean-reg (set %)) coll)))

(defn -main
  "Run Task 1 with a given input REG & COLL, defaulting to the first example
  from the task description."
  [& args]
  (let [[reg coll] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (prn (registration-number reg coll))))
