(ns build
  (:refer-clojure :exclude [test])
  (:require [org.corfield.build :as bb]))

(def lib 'net.clojars.c233/c233)
(def version "0.1.0-SNAPSHOT")
(def main 'c233.c233)

(defn test "Run the tests." [opts]
  (bb/run-tests opts))

(def clean bb/clean)

(defn ci "Run the CI pipeline of tests (and build the uberjar)." [opts]
  (-> opts
      (assoc :lib lib :version version :main main)
      (bb/run-tests)
      (bb/clean)
      (bb/uber)))
