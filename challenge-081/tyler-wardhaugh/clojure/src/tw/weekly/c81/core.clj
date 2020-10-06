(ns tw.weekly.c81.core
 (:require [tw.weekly.c81.t1 :as t1])
 (:gen-class))

(defn -main
  "Run all tasks"
  [& _]
  (println "Task #1")
  (t1/-main))
