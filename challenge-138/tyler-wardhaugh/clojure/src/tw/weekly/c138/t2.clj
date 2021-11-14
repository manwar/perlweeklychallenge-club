(ns tw.weekly.c138.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]
            [clojure.string :as str]
            [clojure.math.numeric-tower :refer [sqrt expt]]))

;;;
; Task description for TASK #2 › Split Number
;;;
(def DEFAULT-INPUT [81])

(defn ->int
  [n] (Integer/parseInt n 10))

(defn n->break [len n]
  (-> n
      (bit-shift-left 1)
      (->> (cl-format nil "~v,'0b" len))
      (str/escape {\1 \+ \0 \-})))

(defn get-splits
  [n]
  (let [s (str n)
        len (count s)
        breaks (map (partial n->break len) (range 1 (expt 2 (dec len))))
        join-nums (fn [coll]
                    (when (not= [\+] coll)
                      (->> coll (remove #{\-}) (str/join "") ->int)))
        xf (map (comp (partial keep join-nums)
                      (partial partition-by #{\+})
                      (partial interleave s)))]
    (sequence xf breaks)))

(defn sum-of-splits?
  [n]
  (let [source (get-splits n)
        xf (comp (map (partial reduce +)) (keep #(when (= % (sqrt n)) true)))
        f (completing (fn [_ v] (reduced v)))]
    (transduce xf f false source)))

(defn -main
  "Run Task 2 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (if (sum-of-splits? N) 1 0))))
