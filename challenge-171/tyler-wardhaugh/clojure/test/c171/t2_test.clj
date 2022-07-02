(ns c171.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c171.t2 :refer [compose f g]]))

(deftest task-2
  (testing "Task 2 produces the correct result")
  (is (= '(f (g "Hello" "there.")) ((compose f g) "Hello" "there."))))
