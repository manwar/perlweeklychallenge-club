(ns tw.weekly.c103-test
  (:require [clojure.test :refer [deftest is testing]]
            [tw.weekly.c103.t1 :refer [chinese-zodiac-simple chinese-zodiac-time4j]]
            [tw.weekly.c103.t2 :refer [currently-playing DEFAULT-INPUT]]))

(deftest task-1
  (testing "Task 1, Chinese Zodiac"
    (let [both (juxt chinese-zodiac-simple chinese-zodiac-time4j)]
      (is (apply = "Fire Rooster" (both 2017)))
      (is (apply = "Earth Tiger" (both 1938))))))

(deftest task-2
  (testing "Task 2, What's playing?"
    (is (= ["Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
            624160]
           (apply currently-playing DEFAULT-INPUT)))))
