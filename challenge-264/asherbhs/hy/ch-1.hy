(defn greatest-english-letter [str] (do
  (setv
    upper #{}
    lower #{}
  )
  (for [c str]
    (if (c.isupper)
      (upper.add c)
      (lower.add (c.upper))
    )
  )
  (setv letters (& upper lower))
  (if letters (max letters) "")
))

(print (greatest-english-letter "PeRlwEeKLy"))
(print (greatest-english-letter "ChaLlenge"))
(print (greatest-english-letter "The"))
