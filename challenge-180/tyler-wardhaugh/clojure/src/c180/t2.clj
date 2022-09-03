(ns c180.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [])

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    N))
