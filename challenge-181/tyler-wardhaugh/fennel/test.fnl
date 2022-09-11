((require :busted.runner))

(local OUTPUT "../clojure/resources/output1.txt")

(describe
  "Task 1, Sentence Order"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t1 (require :t1)
                output (-> (t1.slurp OUTPUT) (: :gsub "\n$" ""))]
            (assert.is.equal output (t1.sentence-order t1.INPUT)))))))

(describe
  "Task 2, Hot Day"
  (fn []
    (it "produces the correct results for the examples given in the description"
        (fn []
          (let [t2 (require :t2)
                expected ["2022-08-02" "2022-08-05" "2022-08-06" "2022-08-08"
                          "2022-08-10"]]
            (assert.same expected (t2.hot-day t2.INPUT)))))))
