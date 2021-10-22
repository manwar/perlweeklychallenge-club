(ns tw.weekly.c135.t1
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #1 › Middle 3-digits
;;;
(def DEFAULT-INPUT [1234567])

(defn abs
  "Return the absolute value of n."
  [n]
  (if (pos? n) n (- n)))

(defn middle-3
  "Find the middle 3-digits of the given integer n if possible, otherwise throw
  a sensible error."
  [n]
  {:pre [(int? n)]}
  (let [sn (-> n abs str)
        len (count sn)]
    (cond
      (even? len) (throw (ex-info "even number of digits" {"length" len}))
      (< len 3) (throw (ex-info "too short" {"length" len}))
      :else (subs sn (dec (/ len 2)) (+ 2 (/ len 2))))))

(defn -main
  "Run Task 1 with a given input N, defaulting to the first example from the
  task description."
  [& args]
  (let [[N] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (try
      (println (middle-3 N))
      (catch Exception e
        (cl-format true "error: ~a (~:{~a=~s~^, ~})~%"
                   (.getMessage e)
                   (ex-data e))))))
