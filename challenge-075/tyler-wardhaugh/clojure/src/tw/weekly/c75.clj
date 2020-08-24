(ns tw.weekly.c75
  (:require [tw.weekly.ch-1 :as ch-1])
  (:require [tw.weekly.ch-2 :as ch-2])
  (:gen-class))

(defn -main
  "Run both tasks."
  [& args]
  (println "Task #1")
  (ch-1/-main)
  (println "\n\nTask #2")
  (ch-2/-main))
