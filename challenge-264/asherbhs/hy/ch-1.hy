(import hyrule *)

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

(pprint (greatest-english-letter "PeRlwEeKLy"))
(pprint (greatest-english-letter "ChaLlenge"))
(pprint (greatest-english-letter "The"))
