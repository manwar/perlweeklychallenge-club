(ns c185.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c185.t2 :refer [mask-code]]))

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= (map mask-code '("ab-cde-123", "123.abc.420", "3abc-0010.xy"))
           '("xx-xxe-123", "xxx.xbc.420", "xxxx-0010.xy")))
    (is (= (map mask-code '("1234567.a", "a-1234-bc", "a.b.c.d.e.f"))
           '("xxxx567.a", "x-xxx4-bc", "x.x.x.x.e.f")))))
