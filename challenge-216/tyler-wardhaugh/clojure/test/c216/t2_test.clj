(ns c216.t2-test
  (:require [clojure.test :refer [deftest is testing]]
            [c216.t2 :refer [word-stickers]]))

(deftest task-2
  (testing "Task 2 produces the correct results from examples in the description"
    (is (= 2 (word-stickers "peon" ["perl" "raku" "python"])))
    (is (= 3 (word-stickers "goat" ["love" "hate" "angry"])))
    (is (= 4 (word-stickers "accommodation" ["come" "nation" "delta"])))
    (is (= 0 (word-stickers "accommodation" ["come" "country" "delta"])))))
