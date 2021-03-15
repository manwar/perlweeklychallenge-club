(ns tw.weekly.c95.stack
  (:refer-clojure :exclude [pop min])
  (:require [clojure.data.finger-tree :as ft]))

(defprotocol PStack
  "A stack protocol"
  (push [this v] "Push a value onto the stack")
  (pop [this] "Pop a value from the top of the stack")
  (top [this] "See the top of the stack (a.k.a. peek)")
  (min [this] "Return the minumum value of the stack"))

(defrecord FTStack [coll]
  PStack
  (push [_ v]
    (FTStack. (conj coll v)))
  (pop [_]
    (FTStack. (.pop coll)))
  (top [_]
    (.peek coll))
  (min [_]
    (reduce clojure.core/min coll)))

(defn make-stack
  ([] (->FTStack (ft/double-list)))
  ([coll] (->FTStack (into (ft/double-list) coll))))
