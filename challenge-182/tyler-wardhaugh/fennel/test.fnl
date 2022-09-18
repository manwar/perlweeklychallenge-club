((require :busted.runner))

(describe
  "Task 1, Max Index"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t1 (require :t1)]
            (assert.is.equal 2 (t1.max-index [5 2 9 1 7 6]))
            (assert.is.equal 4 (t1.max-index [4 2 3 1 5 0])))))))

(describe
  "Task 2, Common Path"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t2 (require :t2)]
            (assert.is.equal "/a/b/c/" (t2.common-path t2.DEFAULT-INPUT)))))))
