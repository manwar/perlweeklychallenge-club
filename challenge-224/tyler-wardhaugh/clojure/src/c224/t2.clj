(ns c224.t2
  (:require
    [clojure.edn :as edn]
    [net.cgrand.xforms :as x]))

(def DEFAULT-INPUT ["112358"])

(defn coll->n
  [coll]
  (->> coll (x/str identity) parse-long))

(defn additive-number?
  [s]
  (let [sv (into [] (map #(Character/digit % 10)) s)
        len (count sv)
        xf (x/for [i %
                   j (range 1 (- len i))
                   :let [n1 (-> sv (subvec 0 i) coll->n)
                         n2 (-> sv (subvec i (+ i j)) coll->n)
                         rsv (-> sv (subvec (+ i j) len))]]
             [n1 n2 rsv])
        f (fn f [_ [n1 n2 rsv]]
            (let [sum (+ n1 n2)
                  sumlen (-> sum str count)]
              (when (<= sumlen (count rsv))
                (let [n3 (-> rsv (subvec 0 sumlen) coll->n)
                      rrsv (-> rsv (subvec sumlen (count rsv)))]
                  (when (= sum n3)
                    (if (zero? (count rrsv))
                      (reduced true)
                      (f nil [n2 n3 rrsv])))))))]
    (boolean (transduce xf (completing f) nil (range 1 len)))))

(defn -main
  "Run Task 2 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or args DEFAULT-INPUT)]
    (println (if (additive-number? N) "true" "false"))))
