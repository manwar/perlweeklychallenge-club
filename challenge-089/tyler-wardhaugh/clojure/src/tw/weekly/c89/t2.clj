(ns tw.weekly.c89.t2
  (:require [clojure.tools.macro :refer [symbol-macrolet]])
  (:require [clojure.core.logic :as l])
  (:require [clojure.core.logic.fd :as fd]))

;;;
; Task description for TASK #2 › Magical Matrix
;;;

(defn magic-matrix
  "Compute the magic matrix for a 3x3 square."
  []
  (symbol-macrolet
    [_ (l/lvar)]
    (let [a _ b _ c _
          d _ e _ f _
          g _ h _ i _
          m [[a b c] [d e f] [g h i]]
          cm (apply concat m)]
     (first
       (l/run 1 [q]
              (l/== q m)
              (l/everyg (fn [q] (fd/in q (fd/interval 1 9))) cm)
              (fd/distinct cm)
              (fd/eq
                (= 15 (+ a b c))
                (= 15 (+ d e f))
                (= 15 (+ g h i))
                (= 15 (+ a d g))
                (= 15 (+ b e h))
                (= 15 (+ c f i))
                (= 15 (+ a e i))
                (= 15 (+ c e g))))))))

(defn -main
  "Run Task 2"
  []
  (run! println (magic-matrix)))
