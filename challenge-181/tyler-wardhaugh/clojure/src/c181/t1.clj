(ns c181.t1
  (:require [clojure.java.io :as io]
            [clojure.pprint :refer [cl-format]]
            [clojure.string :as str]))

(def INPUT (io/resource "input1.txt"))

(defn wrap
  [s width indent]
  (let [recipe (str indent "~{~<~%" indent "~1," width ":;~A~>~#[.~:; ~]~}~%")]
    (-> (cl-format nil recipe (str/split s #"\s+"))
        (str/replace #" \n" "\n"))))

(defn sort-words
  [sentence]
  (->> sentence
       (remove #(= "" %1))
       (sort-by str/lower-case)
       (str/join " ")))

(defn sentence-order
  [input]
  (let [lead (re-find #"^\s+" input)
        longest-width (->> (str/split-lines input) (map count) (apply max))
        sentences (str/split input #"\.\s*")
        graf (->> sentences
                  (map #(str/split %1 #"\s+"))
                  (map sort-words)
                  (str/join ". "))]
    (wrap graf longest-width lead)))

(defn -main
  "Run Task 1 with the input given in the task description."
  [& _]
  (print (sentence-order (slurp INPUT))))
