(ns tw.weekly.c135.t2)

;;;
; Task description for TASK #2 › Validate SEDOL
;;;
(def DEFAULT-INPUT ["2936921"])

(let [weights [1 3 1 7 3 9]]
  (defn check-digit
    [coll]
    (let [source (map vector coll weights)
          xf (map (fn [[c w]] (* (Character/digit c 36) w)))
          sum (transduce xf + source)]
      (mod (- 10 (mod sum 10)) 10))))

(defn sedol?
  [s]
  {:pre [(>= 7 (count s))]}
  (let [candidate (subs s 0 6)
        modulus (-> s (nth 6) (Character/digit 10))]
    (when (re-matches #"^[\d\p{Upper}&&[^AEIOU]]{6}\d" s)
      (= modulus (check-digit candidate)))))

(defn -main
  "Run Task 2 with a given input SEDOL, defaulting to the first example from
  the task description."
  [& args]
  (let [[SEDOL] (or args DEFAULT-INPUT)]
    (println (if (sedol? SEDOL) 1 0))))
