(ns c185.t1
  (:require [clojure.string :as str]))

(def DEFAULT-INPUT ["1ac2.34f0.b1c2"])

(defn convert-mac-address
  [addr]
  (let [source (partition 2 (str/replace addr "." ""))
        xf (comp (interpose ":") cat)]
    (str/join (sequence xf source))))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
   task description."
  [& args]
  (let [[N] (or args DEFAULT-INPUT)]
    (println (convert-mac-address N))))
