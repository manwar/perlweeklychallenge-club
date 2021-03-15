(ns tw.weekly.c97.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]))

;;;
; Task description for TASK #1 › Caesar Cipher
;;;

(def DEFAULT-INPUT ["THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG" 3])
(def ALPHABET "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(def ALEN (count ALPHABET))

(defn caesar
  [s n]
  (let [cipher (->> (repeat ALPHABET)
                    (mapcat seq)
                    (drop (- ALEN n))
                    (take ALEN)
                    (zipmap ALPHABET))]
    (str/escape s cipher)))

(defn -main
  "Run Task 1 using a string S and shift size S, defaulting to the example
  given in the task description."
  [& args]
  (let [[S N] (or (some->> args (take 2) edn/read-string) DEFAULT-INPUT)
        ciphertext (caesar S N)]
    (println "Plaintext:  " S "\nCiphertext: " ciphertext)))
