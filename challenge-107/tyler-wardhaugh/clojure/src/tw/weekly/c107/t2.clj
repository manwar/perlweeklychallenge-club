(ns tw.weekly.c107.t2
  (:require [clojure.reflect :refer [reflect]]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › List Methods
;;;
(def DEFAULT-INPUT "java.lang.Object")

(defn list-methods
  "Return a list of methods on classname"
  [classname]
  (let [source (->> (Class/forName classname) reflect :members)
        xf (comp (filter :return-type) (map :name))]
    (into #{} xf source)))

(defn -main
  "Run Task 2 with a given CLASSNAME, defaulting to a standard Java class"
  [& args]
  (let [CLASSNAME (or (some-> args first) DEFAULT-INPUT)]
    (cl-format true "~{~a~%~}" (list-methods CLASSNAME))))
