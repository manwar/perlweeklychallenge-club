(ns tw.weekly.c94.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Group Anagrams
;;;

(def DEFAULT-INPUT '("opt", "bat", "saw", "tab", "pot", "top", "was"))

(defn group-anagrams
  "Group anagrams from `coll` together."
  [coll]
  (->> coll
       (group-by frequencies)
       vals))

(defn -main
  "Run Task 1 using an array of strings S, defaulting to the example given in
  the task description."
  [& args]
  (let [S (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "[ ~{(~{~s~^, ~})~^,~%  ~} ]~%" (group-anagrams S))))
