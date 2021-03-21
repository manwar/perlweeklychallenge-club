(ns tw.weekly.c104.t2
  (:require [clojure.pprint :refer [cl-format]]))

;;;
; Task description for TASK #2 › NIM Game
;;;

(def TOKENS 12)
(def MAX 3)
(def PLAYERS {:player "Player", :cpu "Computer"})

(defn play-nim
  []
  (let [winner
        (loop [tokens TOKENS]
          (cl-format true "~&~d token~:p left; enter a number between 1 and ~d to take: "
                     tokens (min MAX tokens))
          (let [p1-taken (try (Integer/parseInt (read-line))
                           (catch NumberFormatException _ 0))
                valid? (<= 1 p1-taken (min MAX tokens))
                next-tokens (if valid? (- tokens p1-taken) tokens)]
            (cond
              (not valid?) (recur next-tokens)
              (zero? next-tokens) :player
              :else (let [cpu-taken (inc (rand-int (min MAX next-tokens)))]
                      (cl-format true "Computer takes ~d token~:p~%" cpu-taken)
                      (if (zero? (- next-tokens cpu-taken))
                        :cpu
                        (recur (- next-tokens cpu-taken)))))))]
    (cl-format true "~&~a wins!!!~%" (get PLAYERS winner "Nobody"))))

(defn -main
  "Run Task 2."
  [& _]
  (play-nim))
