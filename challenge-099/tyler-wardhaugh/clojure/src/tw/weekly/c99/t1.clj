(ns tw.weekly.c99.t1
  (:import (java.nio.file FileSystems Paths))
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #1 › Pattern Match
;;;

(def DEFAULT-INPUT ["abcde" "a*e"])
(def FILESYSTEM (FileSystems/getDefault))

(defn pattern-match
  "Determine if string s matches the given (glob) pattern."
  [s pattern]
  (let [matcher (.getPathMatcher FILESYSTEM (str "glob:" pattern))
        s-path (Paths/get s (into-array String ""))]
    (.matches matcher s-path)))

(defn -main
  "Run Task 1 using a string S and a pattern P, defaulting to the example
  given in the task description."
  [& args]
  (let [[S P] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (pattern-match S P) 1 0))))
