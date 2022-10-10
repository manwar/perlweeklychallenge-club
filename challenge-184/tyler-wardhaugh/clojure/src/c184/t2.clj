(ns c184.t2
  (:require [clojure.edn :as edn]))

(def DEFAULT-INPUT [["a 1 2 b 0" "3 c 4 d"]])

(def int-char? (set "0123456789"))
(def alpha-char? (set "abcdefghijklmnopqrstuvwxyz"))

(defn split-array
  [coll]
  (let [xf (map (fn [s] [(keep #(when (int-char? %) (Character/digit % 10)) s)
                         (keep #(when (alpha-char? %) (str %)) s)]))
        f (fn [[integers alphas] [i a]]
            [(if (seq i) (conj integers i) integers)
             (if (seq a) (conj alphas a) alphas)])]
    (transduce xf (completing f) [[] []] coll)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)
        [integers alphas] (split-array N)]
    (println integers "and" (pr-str alphas))))
