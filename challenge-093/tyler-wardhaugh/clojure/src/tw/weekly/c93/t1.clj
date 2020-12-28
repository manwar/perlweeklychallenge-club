(ns tw.weekly.c93.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Max Points
;;;

(def DEFAULT-INPUT [])

(defn -main
  "Run Task 1 using two given strings, defaulting to the example given in
  the task description."
  [& args]
  (let [[] (or (some->> args (take 2) edn/read-string) DEFAULT-INPUT)]
    ))
