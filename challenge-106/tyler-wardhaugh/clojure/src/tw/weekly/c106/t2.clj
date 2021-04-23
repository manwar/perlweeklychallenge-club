(ns tw.weekly.c106.t2
  (:require [clojure.edn :as edn]
            [clojure.math.numeric-tower :refer [abs]]))

;;;
; Task description for TASK #2 › Decimal String
;;;
(def DEFAULT-INPUT [1 3])

(defn- decimal-string-recurring
  "Covert the given n[umerator] and d[enominator] (which must be known to
  have a recurring fractional result) into a decimal string where the recurring
  fractional is put in parenthesis."
  [n d]
  (loop [remainder (abs (rem n d))
         cache {}
         result []]
    (if (not (or (zero? remainder) (cache remainder)))
      (recur (rem (* 10 remainder) d)
             (assoc cache remainder (count (apply str result)))
             (conj result (quot (* 10 remainder) d)))
      (let [[lead recurrence] (->> result (split-at (get cache remainder 0)))
            whole (quot n d)
            pieces (concat [whole \.] lead [\(] recurrence [\)])]
        (apply str pieces)))))

(defn decimal-string
  "Covert the given n[umerator] and d[enominator] into a decimal string where any
  recurring fractional is put in parenthesis."
  [n d]
  (try (str (/ (bigdec n) d))
       (catch ArithmeticException _
         ; BigDecimal throws this exception when the result cannot be
         ; represented with the 'UNLIMITED' precision (the default), i.e.,
         ; there is a recurring fractional result
         (decimal-string-recurring n d))))

(defn -main
  "Run Task 2 with a given N and D, defaulting to the example given in the task
  description."
  [& args]
  (let [[N D] (or (some->> args (take 2) (map edn/read-string)) DEFAULT-INPUT)]
    (println (decimal-string N D))))
