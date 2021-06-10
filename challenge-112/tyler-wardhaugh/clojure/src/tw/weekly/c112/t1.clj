(ns tw.weekly.c112.t1
  (:require [clojure.edn :as edn])
  (:import (java.nio.file Path)))

;;;
; Task description for TASK #1 › Canonical Path
;;;
(def DEFAULT-INPUT "/a/")

(defn canonicalize
  "Convert an absolute path to a simplified canonical one"
  [path]
  (let [p (Path/of path (into-array String ""))]
    (-> p .normalize str)))

(defn -main
  "Run Task 1."
  [& args]
  (let [path (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (canonicalize path))))
