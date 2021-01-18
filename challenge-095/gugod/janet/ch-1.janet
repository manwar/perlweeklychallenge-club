
(defn is-palindrome
  "Tell if the given string is a palindrome"
  [s]
  (= s (string/reverse s)))

(defn is-palindrome-number
  "Tell if the given number is palindromic"
  [n]
  (is-palindrome (string n)))

(loop [n :in @[1221 -101 90]]
  (print (string
        "Input: " n "\n"
        "Output: " (if (is-palindrome-number n) 1 0) "\n")))
