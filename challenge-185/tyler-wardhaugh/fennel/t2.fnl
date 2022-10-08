; Task 2 — Mask Code

(local fennel (require :fennel))
(local DEFAULT-INPUT [["ab-cde-123" "123.abc.420" "3abc-0010.xy"]])


(fn mask-code
  [code]
  (icollect [_ v (ipairs code)]
    (do
      (var cnt 0)
      (: v :gsub "[%a%d]"
         #(if (< cnt 4)
            (do (set cnt (+ 1 cnt)) "x")
            $1)))))


(fn main
  []
  (match arg
    ["-e" _ & n] (-> DEFAULT-INPUT (. 1) mask-code fennel.view print)
    _ (do
        (print "error: see README.md for invocation")
        (os.exit 1))))


{ : main : mask-code }
