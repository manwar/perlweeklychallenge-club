(ns c225.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [c225.t1 :refer [max-words]]))

(deftest task-1
  (testing "Task 1 produces the correct results from examples in the description"
    (is (= 8 (max-words ["Perl and Raku belong to the same family."
                         "I love Perl."
                         "The Perl and Raku Conference."])))
    (is (= 7 (max-words ["The Weekly Challenge."
                         "Python is the most popular guest language.",
                         "Team PWC has over 300 members."])))))
