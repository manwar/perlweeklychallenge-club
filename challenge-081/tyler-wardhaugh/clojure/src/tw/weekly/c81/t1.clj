(ns tw.weekly.c81.t1)

;;; Task description for TASK #1 › Common Base String
; You are given 2 strings, $A and $B.
;
; Write a script to find out common base strings in $A and $B.
;
; >>> A substring of a string $S is called base string if repeated concatenation of the substring results in the string.;
;;;

(defn common-base-string
  "Find the common base string of two strings."
  [s1 s2]
  (let [[[_ small] [large-len large]] (->> [s1 s2] (map (juxt count identity)) sort)
        is-substring (fn [s] (= large (reduce str (-> (quot large-len (count s)) (repeat s)))))]
    (->> (reductions str "" small)
         (drop 1)
         (filter #(zero? (rem large-len (count %))))
         (filter is-substring))))

(defn -main
  "Run Task 1 with two strings A and B, defaulting to the first example given in the task description."
  [& args]
  (let [[A B] (or (some->> args (take 2)) ["abcdabcd" "abcdabcdabcdabcd"])
        base (common-base-string A B)]
    (println base)))
