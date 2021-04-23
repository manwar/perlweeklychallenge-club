(ns tw.weekly.c108.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › Bell Numbers
;;;
(def DEFAULT-INPUT 10)

;;;
; translation of:
;   (Haskell)
;   a011971 n k = a011971_tabl !! n !! k
;   a011971_row n = a011971_tabl !! n
;   a011971_tabl = iterate (\row -> scanl (+) (last row) row) [1]
; source:
;   https://oeis.org/A011971
;     Aitken's array: triangle of numbers {a(n,k), n >= 0, 0 <= k <= n} read by
;     rows, defined by a(0,0)=1, a(n,0) = a(n-1,n-1), a(n,k) = a(n,k-1) +
;     a(n-1,k-1).
; linked from:
;   https://oeis.org/A000110
;     Bell or exponential numbers: number of ways to partition a set of n
;     labeled elements.
;;;
(defn bell-numbers
  "Return a list of the first n Bell Numbers"
  [n]
  (let [f (fn [row] (reductions + (last row) row))
        table (concat [[1]] (take (dec n) (iterate f [1])))]
    (sequence (map last) table)))

(defn -main
  "Run Task 2 with a given CLASSNAME, defaulting to a standard Java class"
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "~{~a~^, ~}~%" (bell-numbers N))))
