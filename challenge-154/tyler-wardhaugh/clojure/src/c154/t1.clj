(ns c154.t1
  (:require [clojure.pprint :refer [cl-format]]
            [clojure.set :as set]
            [clojure.math.combinatorics :as combo]))

(def GIVEN-BASE "PERL")
(def GIVEN-PERMS 
  ["PELR" "PREL" "PERL" "PRLE" "PLER" "PLRE" "EPRL" "EPLR" "ERPL"
   "ERLP" "ELPR" "ELRP" "RPEL" "RPLE" "REPL" "RELP" "RLPE" "RLEP"
   "LPER" "LPRE" "LEPR" "LRPE" "LREP"])

(defn find-missing
  [base partial-perms]
  (let [all-perms (into #{} (map #(apply str %)) (combo/permutations base))]
    (set/difference all-perms (set partial-perms))))

(defn -main
  "Run Task 1."
  [& args]
  (cl-format true "~{~a~^, ~}~%" (find-missing GIVEN-BASE GIVEN-PERMS)))
