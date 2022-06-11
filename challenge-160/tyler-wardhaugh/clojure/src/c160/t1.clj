(ns c160.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [5])

(defn n->en
  [n]
  (cl-format nil "~r" n))

(defn magic-seq
  [n]
  (loop [n n
         result [n]]
    (let [len (-> n n->en count)]
      (if (= len 4)
        (conj result len)
        (recur len (conj result len))))))

(defn spell
  [n]
  (->> (magic-seq n)
       (partition 2 1)
       (cl-format nil "~@(~:{~r is ~r, ~}four is magic.~)")))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (spell N))))
