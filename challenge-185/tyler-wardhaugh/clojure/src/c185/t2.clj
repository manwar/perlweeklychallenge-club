(ns c185.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

(def DEFAULT-INPUT ['("ab-cde-123", "123.abc.420", "3abc-0010.xy")])
(def MASK-MAX 4)
(def MASK-CHAR \x)

(defn mask-code
  [code]
  (->> (str/split code #"[a-z0-9]" (inc MASK-MAX))
       (str/join MASK-CHAR)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (prn (map mask-code N))))
