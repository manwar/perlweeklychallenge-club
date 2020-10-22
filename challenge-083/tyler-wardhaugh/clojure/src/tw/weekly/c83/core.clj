(ns tw.weekly.c83.core
  (:require [tw.weekly.c83.t1 :as t1])
  (:require [tw.weekly.c83.t2 :as t2])
  (:gen-class))

(defn -main
  "Run all tasks"
  [& _]
  (println "Task #1")
  (t1/-main)
  (println "Task #2")
  (t2/-main))
