(ns tw.weekly.c114.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2 › Higher Integer Set Bits
;;;
(def DEFAULT-INPUT 3)

(defn higher-int-set-bits
  [n]
  (let [source (->> n inc (iterate inc))
        ones (Integer/bitCount n)
        xf (filter #(= ones (Integer/bitCount %)))]
    (->> source (sequence xf) first)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (higher-int-set-bits N))))
