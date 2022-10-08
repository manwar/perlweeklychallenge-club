; Task 1 — MAC address

(local DEFAULT-INPUT ["1ac2.34f0.b1c2"])


(fn convert-mac-address
  [addr]
  (-> addr
      (: :gsub "%." "")
      (: :gsub "(..)" "%1:")
      (: :sub 1 -2)))


(fn main
  []
  (match arg
    (where ["-e" _ & n] (< 0 (length n))) (print (convert-mac-address (. n 1)))
    ["-e" _ & n] (print (convert-mac-address (. DEFAULT-INPUT 1)))
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))


{ : main : convert-mac-address }
