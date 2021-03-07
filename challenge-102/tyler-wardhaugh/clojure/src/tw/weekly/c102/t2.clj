(ns tw.weekly.c102.t2
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #2 › Hash-counting String
;;;

(def DEFAULT-INPUT 1)

(defn hash-counting-str
  "Return a hash-counting str of lengh `n`."
  [n]
  (let [source (take (inc n) (cycle [false true]))
        f (fn [[index result] hash]
            (if (<= index 0)
              (reduced result)
              (if hash
                ((juxt #(- index (count %)) #(conj result %)) (-> index inc str))
                [(dec index) (conj result \#)])))]
    (->>
      (reduce f [n []] source)
      reverse
      str/join)))

(defn -main
  "Run Task 2 with N, defaulting to the example given in the task description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (println (hash-counting-str N))))
