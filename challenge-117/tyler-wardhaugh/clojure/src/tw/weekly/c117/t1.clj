(ns tw.weekly.c117.t1
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Missing Row
;;;
(def DEFAULT-INPUT [])

(defn missing-row
  [file])

(defn -main
  "Run Task 1 with a given input FILE, defaulting to the first example from the
  task description."
  [& args]
  (let [[FILE] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (missing-row FILE))))
