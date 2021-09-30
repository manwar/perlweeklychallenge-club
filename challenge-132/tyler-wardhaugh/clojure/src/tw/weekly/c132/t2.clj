(ns tw.weekly.c132.t2
  (:require [clojure.edn :as edn]
            [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2, Hash Join
;;;
(def MAXSIZE "The maximum number of build relations to process at one time." 3)
(def DEFAULT-INPUT
  [[[20, "Alex"  ]
    [28, "Joe"   ]
    [38, "Mike"  ]
    [18, "Alex"  ]
    [25, "David" ]
    [18, "Simon" ]]
   [["Alex", "Stewart"]
    ["Joe",  "Root"   ]
    ["Mike", "Gatting"]
    ["Joe",  "Blog"   ]
    ["Alex", "Jones"  ]
    ["Simon","Duane"  ]]
   1
   0])

(defn butnth
  "Returns all values except the one at index."
  [coll index]
  (keep-indexed (fn [i v] (when (not= i index) v)) coll))

;;; Classic Hash Join
;; Algorithm description:
;   https://en.wikipedia.org/wiki/Hash_join#Classic_hash_join
;; Notes:
;   - We proactively batch the smaller relation (build) into MAXSIZE chunks to
;     ensure it can fit into memory.
;   - Order of output relation is not guaranteed.
;;;
(defn hash-join
  [a b a-index b-index]
  (let [[build build-index probe probe-index]
        (if (<= (count a) (count b))
          [a a-index b b-index]
          [b b-index a a-index])]
    (-> (comp
          (partition-all MAXSIZE)
          (map (fn [batch] (group-by #(nth % build-index) batch)))
          (mapcat
            (fn [build-map]
              (keep (fn [row]
                      (when-let [ks (build-map (nth row probe-index))]
                        (map #(concat % (butnth row probe-index)) ks)))
                    probe)))
          cat)
        (sequence build))))

(defn -main
  "Run Task 1 with a given input H1, H2, I1, and I2, defaulting to the first
  example from the task description."
  [& args]
  (let [[H1 H2 I1 I2] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (->> (hash-join H1 H2 I1 I2)
         (cl-format true "~:{~a, ~s, ~s~%~}"))))
