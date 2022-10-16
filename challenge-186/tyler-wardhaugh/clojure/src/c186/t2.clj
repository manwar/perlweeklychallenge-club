(ns c186.t2
  (:require [clojure.string :as str])
  (:import (java.text Normalizer Normalizer$Form)))

(def DEFAULT-INPUT ["ÃÊÍÒÙ"])

(defn makeover
  [s]
  (-> s
      (Normalizer/normalize Normalizer$Form/NFKD)
      (str/replace #"\p{InCombiningDiacriticalMarks}+" "")))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or args DEFAULT-INPUT)]
    (println (makeover N))))
