(ns tw.weekly.c140.t1)

;;;
; Task description for TASK #1 › Add Binary
;;;
(def DEFAULT-INPUT ["11" "1"])

(defn binstr->num
  [s]
  (Long/parseLong s 2))

(defn num->binstr
  [n]
  (Long/toString n 2))

(defn add-binary
  [& binstrs]
  (->> binstrs
       (transduce (map binstr->num) +)
       num->binstr))

(defn -main
  "Run Task 1 with a given input A B, defaulting to the first example from the
  task description."
  [& args]
  (let [[A B] (or args DEFAULT-INPUT)]
    (println (add-binary A B))))
