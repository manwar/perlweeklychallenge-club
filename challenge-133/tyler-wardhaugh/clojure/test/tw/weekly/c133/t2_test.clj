(ns tw.weekly.c133.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c133.t2 :refer [smiths]]))

; source: https://oeis.org/A006753/list
(def oeis-smith-numbers
  [4,22,27,58,85,94,121,166,202,265,274,319,346,355,
   378,382,391,438,454,483,517,526,535,562,576,588,
   627,634,636,645,648,654,663,666,690,706,728,729,
   762,778,825,852,861,895,913,915,922,958,985,1086,
   1111,1165,1219])

(deftest first-10
  (testing "Verify the first 10 Smith Numbers"
    (is (= (take 10 oeis-smith-numbers) (take 10 smiths)))))
