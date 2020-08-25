(ns tw.weekly.ch-2
  (:require [clojure.edn :as edn]))

(defn -main
  "Run Task 2 with a list of integers, defaulting to the sample given in the task description."
  [& args]
  (let [A (if (not-empty args) (map edn/read-string args) [2, 1, 4, 5, 3, 7])]
    (println A)))

(-main)
