(ns c191.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c191.t2 :refer [cute-list]]))

; "Cute List" results for n = 0 .. 15
; from: https://oeis.org/A320843/list
(def A320843 [1 1 2 3 8 10 36 41 132 250 700 750 4010 4237 10680 24679])

(deftest task-2
  (testing "Task 2 produces the correct results"
    (is (= A320843 (map cute-list (range 16))))))
