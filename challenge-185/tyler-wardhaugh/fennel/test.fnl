((require :busted.runner))


(describe
  "Task 1, MAC address"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t1 (require :t1)]
            (assert.is.equal "1a:c2:34:f0:b1:c2" (t1.convert-mac-address "1ac2.34f0.b1c2"))
            (assert.is.equal "ab:c1:20:f1:34:5a" (t1.convert-mac-address "abc1.20f1.345a")))))))


(describe
  "Task 2, Mask Code"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t2 (require :t2)]
            (assert.same (t2.mask-code ["ab-cde-123" "123.abc.420" "3abc-0010.xy"])
                         ["xx-xxe-123" "xxx.xbc.420" "xxxx-0010.xy"])
            (assert.same (t2.mask-code ["1234567.a" "a-1234-bc" "a.b.c.d.e.f"])
                         ["xxxx567.a" "x-xxx4-bc" "x.x.x.x.e.f"]))))))
