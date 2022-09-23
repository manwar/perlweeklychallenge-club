(ns c183.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c183.t2 :refer [formatted-date-diff]]))

(deftest task-2
  (testing "Task 2 produces the correct result"
    (is (= (formatted-date-diff "2019-02-10" "2022-11-01") "3 years 264 days"))
    (is (= (formatted-date-diff "2020-09-15" "2022-03-29") "1 year 195 days"))
    (is (= (formatted-date-diff "2019-12-31" "2020-01-01") "1 day"))
    (is (= (formatted-date-diff "2019-12-01" "2019-12-31") "30 days"))
    (is (= (formatted-date-diff "2019-12-31" "2020-12-31") "1 year"))
    (is (= (formatted-date-diff "2019-12-31" "2021-12-31") "2 years"))
    (is (= (formatted-date-diff "2020-09-15" "2021-09-16") "1 year 1 day"))
    (is (= (formatted-date-diff "2019-09-15" "2021-09-16") "2 years 1 day"))))
