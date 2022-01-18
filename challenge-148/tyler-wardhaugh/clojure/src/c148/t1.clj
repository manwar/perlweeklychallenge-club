(ns c148.t1
  (:require [clojure.pprint :refer [cl-format]]
            [clojure.string :as str]))

(def TARGET 100)

(defn eban?
  [n]
  (-> (cl-format nil "~r" n) (str/includes? "e") not))

(defn -main
  [& _]
  (println (filter eban? (range (inc TARGET)))))
