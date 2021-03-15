
(defn reverse-words
  "Reverse the string word by word"
  [S]
  (string/join (reverse (filter (fn [x] (not (= x "")))
                        (string/split " " S)))
               " "))

# main
(loop [x :in @["The Weekly Challenge"
               "    Perl and   Raku are  part of the same family  "
               "join reverse split $S"]]
  (print (string
        "Input: " x "\n"
        "Output: " (reverse-words x))))
