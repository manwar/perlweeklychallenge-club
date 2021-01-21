
(defn lev
  "Compute the Levenshtein distance between string a and b"
  [a b]
    (cond (= 0 (length a)) (length b)
          (= 0 (length b)) (length a)
          (let [
                a_head (string/slice a 0 1)
                a_tail (string/slice a 1)
                b_head (string/slice b 0 1)
                b_tail (string/slice b 1)
                levtail (lev a_tail b_tail)
                ]
            (if (= a_head b_head) levtail
                (+ 1 (min
                      (lev a b_tail)
                      (lev a_tail b)
                      levtail))))))

# main
(loop [[s1 s2] :in [ ["kitten" "sitting"] ["sunday" "monday"] ]]
  (print (string
          "Input: S1=" s1 " S2=" s2 "\n"
          "Output: " (lev s1 s2))))
