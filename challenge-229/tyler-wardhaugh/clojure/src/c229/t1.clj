(ns c229.t1
  (:require
    [clojure.edn :as edn]))

(def DEFAULT-INPUT [["abc" "bce" "cae"]])

(defn out-of-lex-order
  [coll]
  (let [ordered (->> coll
                     (map seq)
                     (filter #(or (= % (sort %))
                                  (= % (sort (comp - compare) %)))))]
    (- (count coll) (count ordered))))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (out-of-lex-order COLL))))
