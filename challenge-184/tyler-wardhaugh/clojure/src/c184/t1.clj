(ns c184.t1
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [["ab1234" "cd5678" "ef1342"]])

(defn add-seq-number
  [coll]
  (map-indexed (fn [i v] (format "%02d%s" i (subs v 2))) coll))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
   task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (prn (add-seq-number N))))
