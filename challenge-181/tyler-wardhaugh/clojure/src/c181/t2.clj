(ns c181.t2
  (:require [clojure.java.io :as io]
            [clojure.string :as str]
            [net.cgrand.xforms :as x]
            [net.cgrand.xforms.io :as xio]))

(def INPUT (io/resource "temperature.txt"))

(defn parse-input
  [input]
  (let [source (xio/lines-in input)
        xf (map #(-> (str/split % #", ")
                     ((juxt first (comp parse-long second)))))]
    (into (sorted-set) xf source)))

(defn hot-day
  [input]
  (let [days (parse-input input)
        xf (comp
             (x/partition 2 1)
             (keep (fn [[[_ t1] [d2 t2]]]
                     (when (< t1 t2) d2))))]
    (sequence xf days)))

(defn -main
  "Run Task 2 with the input given in the task description."
  [& _]
  (run! println (hot-day INPUT)))
