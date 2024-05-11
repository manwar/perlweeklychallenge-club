(import hyrule *)

(defn magic-number [x y] (- (min y) (min x)))

(pprint (magic-number [3 7 5] [9 5 7]))
(pprint (magic-number [1 2 1] [5 4 4]))
(pprint (magic-number [2]     [5]))
