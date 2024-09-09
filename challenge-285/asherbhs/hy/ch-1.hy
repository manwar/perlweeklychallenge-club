(require hyrule *)

(defn no-connection [routes] (do
  (setv [from to] (map list (zip #* routes)))
  (next (iter (- (set to) (set from))))
))

(print (no-connection ["BC" "DB" "CA"]))
(print (no-connection ["AZ"]))

