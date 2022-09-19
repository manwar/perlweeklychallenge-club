(ns c182.t2
  (:require [clojure.string :as str]))

(def DEFAULT-INPUT
  ["/a/b/c/1/x.pl"
   "/a/b/c/d/e/2/x.pl"
   "/a/b/c/d/3/x.pl"
   "/a/b/c/4/x.pl"
   "/a/b/c/d/5/x.pl"])

(defn common-path
  [coll]
  (->> coll
       (map #(str/split % #"(?<=/)|(?=/)"))
       (apply map vector)
       (sequence (comp (take-while #(apply = %)) (map first)))
       (str/join "")))

(defn -main
  "Run Task 2 with a given input P1 [P2 ...], defaulting to the first example
  from the task description."
  [& args]
  (let [P (or args DEFAULT-INPUT)]
    (println (common-path P))))
