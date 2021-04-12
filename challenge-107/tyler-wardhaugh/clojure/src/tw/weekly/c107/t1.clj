(ns tw.weekly.c107.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Self-descriptive Numbers
;;;
(def DEFAULT-INPUT 3)
(def FIRST-SDN 1210)

(defn self-descriptive?
  "Test whether n is a self-descriptive number"
  [n]
  (let [nstr (str n)
        freq (frequencies nstr)
        f (fn [[i v]]
            (let [cnt (get freq (Character/forDigit i 10) 0)]
              (= cnt (Character/digit v 10))))]
    (every? f (map-indexed vector nstr))))

(defn generate-self-descriptives
  "Generator for self-descriptive numbers"
  [n]
  (let [xf (comp (filter self-descriptive?)
                 (take n))]
    (sequence xf (iterate (partial + 10) FIRST-SDN))))

(defn -main
  "Run Task 1 with a given N, defaulting to the example given in the task
  description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "~{~a~^, ~}" (generate-self-descriptives N))))
