(ns tw.weekly.c81-test
  (:require [clojure.test :refer [deftest is testing]]
            [clojure.java.io :as io]
            [net.cgrand.xforms.io :as xio]
            [tw.weekly.c81.t1 :refer [common-base-string]]
            [tw.weekly.c81.t2 :refer [word-frequency-sort]]))

(deftest task-1
  (testing "Task 1, Common Base String"
    (is (= (common-base-string "abcdabcd" "abcdabcdabcdabcd") ["abcd" "abcdabcd"]))
    (is (= (common-base-string "aaa" "aa") ["a"]))))

(deftest task-2
  (testing "Task 2, Frequency Sort"
    (is (= (word-frequency-sort (xio/lines-in (io/resource "input")))
           (into (sorted-map)
                 {1 (into (sorted-set) #{"But" "City" "It" "Jet" "Juliet" "Latino" "New" "Romeo" "Side" "Story" "Their" "Then" "West" "York" "adaptation" "any" "anything" "at" "award-winning" "away" "become" "before" "begin" "best" "classic" "climactic" "coexist" "control" "dance" "do" "doesn't" "end" "ending" "escalates" "families" "feuding" "form" "former" "friend" "gains" "gangs" "goes" "happened" "hatred" "heartbreaking" "highway" "hoping" "in" "know" "love" "lovers" "meet" "meeting" "neither" "no" "one" "plan" "planning" "point" "romantic" "rumble" "run" "secret" "sends" "sister" "streets" "strikes" "terribly" "their" "two" "under" "understanding" "until" "violence" "warring" "what" "when" "where" "white" "whoever" "wins" "with" "wrong" "younger"})
                  2 (into (sorted-set) #{"Bernardo" "Jets" "Riff" "Sharks" "The" "by" "it" "led" "tragedy"})
                  3 (into (sorted-set) #{"Maria" "Tony" "a" "can" "of" "stop"})
                  4 #{"to"}
                  9 (into (sorted-set) #{"and" "the"})})))))
