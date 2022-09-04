((require :busted.runner))

(describe
  "Task 1, First Unique Character"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t1 (require :t1)]
            (assert.is.equal 0 (t1.first-unique-char "Perl Weekly Challenge"))
            (assert.is.equal 1 (t1.first-unique-char "Long Live Perl")))))))

(describe
  "Task 2, Trim List"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t2 (require :t2)]
            (assert.are.same [4 5] (t2.trim-list [1 4 2 3 5] 3))
            (assert.are.same [9 6 8 5] (t2.trim-list [9 0 6 2 3 8 5] 4)))))))
