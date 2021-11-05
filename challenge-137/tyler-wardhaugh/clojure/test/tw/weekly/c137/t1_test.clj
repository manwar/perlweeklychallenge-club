(ns tw.weekly.c137.t1-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c137.t1 :refer [long-year-temporal? long-year-manual?]]))

(deftest examples
  (testing "Examples from description"
    (let [source (range 1900 2101)]
    (is (= (sequence (filter long-year-temporal?) source)
           (sequence (filter long-year-manual?) source)
           [1903 1908 1914 1920 1925 1931 1936 1942 1948 1953 1959 1964 1970
            1976 1981 1987 1992 1998 2004 2009 2015 2020 2026 2032 2037 2043
            2048 2054 2060 2065 2071 2076 2082 2088 2093 2099])))))
