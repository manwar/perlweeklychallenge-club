(ns tw.weekly.c105.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › The Name Game
;;;
(def DEFAULT-INPUT "Katie")

(def VOWELS (into #{} "AEIOUY"))
(def NAME-FMT-STR (str/join "~%"
                            ["~:(~a~), ~:(~0@*~a~), bo-~(~a~)"
                             "Bonana-fanna fo-~(~a~)"
                             "Fee fi mo-~(~a~)"
                             "~:(~0@*~a!~)"]))

(defn name-game
  "Play the Name Game. A name meeting the rules of the game (as described
  in its Wikipedia entry) is required."
  [name]
  (let [[head & tail] (str/upper-case name)
        head' (if (VOWELS head) "" head)
        tail' (str/join (if (VOWELS head) (conj head tail) tail))]
    (cl-format nil NAME-FMT-STR
               name
               (if (= \B head') tail' (str \B tail'))
               (if (= \F head') tail' (str \F tail'))
               (if (= \M head') tail' (str \M tail')))))

(defn -main
  "Run Task 2 with a given NAME, defaulting to the example given in the task
  description."
  [& args]
  (let [NAME (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (name-game NAME))))
