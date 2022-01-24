(ns c148.t2
  (:require [clojure.math :as m]
            [clojure.pprint :refer [cl-format]]))

;(set! *warn-on-reflection* true)
(def DEFAULT-EPS 1e-6)
(def MAX 100)

(defn one-ish?
  ([n] (one-ish? n DEFAULT-EPS))
  ([n eps] (< (abs (- 1.0 n)) eps)))

; equivalent formula, found at: https://math.stackexchange.com/a/1885139
(defn cardano-triplet?
  [a b c]
  (one-ish? (- (+ (* 8 (m/pow a 3)) 
                  (* 15 (m/pow a 2))
                  (* 6 a))
               (* 27 (m/pow b 2) c))))

(def cardano-triplets
  (for [a (range MAX)
        b (range MAX)
        c (range MAX)
        :when (cardano-triplet? a b c)]
    [a b c]))

(defn -main
  [& _]
  (cl-format true "~{(~{~a~^, ~})~%~}" (take 5 cardano-triplets)))
