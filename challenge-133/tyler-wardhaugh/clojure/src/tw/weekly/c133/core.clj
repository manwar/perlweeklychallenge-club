(ns tw.weekly.c133.core
  (:require [tw.weekly.c133.t1 :as t1])
  (:require [tw.weekly.c133.t2 :as t2])
  (:gen-class))

(defn -main
  "Run all tasks"
  [& _]
  (println "Task #1:")
  (t1/-main)
  (println "\nTask #2:")
  (t2/-main))
