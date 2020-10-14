(ns tw.weekly.c82.t2)

;;; Task description for TASK #2 › Interleave String
; Submitted by: Mohammad S Anwar
; You are given 3 strings; $A, $B and $C.
;
; Write a script to check if $C is created by interleave $A and $B.
;
; Print 1 if check is success otherwise 0.
;;;

(defn interleave-strings
  "Determine if a and b can be interleaved to form c."
  [a b c]
  (cond (every? empty? [a b c]) true
        (not= (+ (count a) (count b)) (count c)) false
        :else
        (let [[[ah at] [bh bt] [ch ct]] (map (juxt first rest) [a b c])]
          (or (and (= ah ch) (interleave-strings at b ct))
              (and (= bh ch) (interleave-strings a bt ct))))))

(defn -main
  "Run Task 2 with an input, defaulting to the example given in the task description."
  [& args]
  (let [[A B C] (or (some->> args (take 3)) ["XY" "X" "XXY"])
        result (interleave-strings A B C)]
    (println (if result 1 0))))
