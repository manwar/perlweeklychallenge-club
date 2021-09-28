(ns tw.weekly.c128.t2
  (:require [clojure.edn :as edn]))

;;;
; Task description for TASK #2, Minimum Platforms
;;;
(def DEFAULT-INPUT [["11:20" "14:30"] ["11:50" "15:00"]])

(def MINUTES-PER-DAY (* 24 60))
(def TIME-REGEX (re-pattern #"([0-2]\d):(\d{2})"))

(defn time->num
  [t]
  (let [[[_ h m]] (re-seq TIME-REGEX t)]
    (+ (* (Integer/parseInt h) 60) (Integer/parseInt m))))

(defn calc-trains-by-minute [arrivals departures]
  (let [source (map vector arrivals departures)
        xf (comp
             (map #(map time->num %))
             (mapcat (fn [[arr dep]]
                       (if (<= arr dep)
                         (range arr dep)
                         (concat (range dep)
                                 (range arr (dec MINUTES-PER-DAY)))))))
        f (completing (fn [minutes i]
                        (doto minutes (aset i (inc (aget minutes i))))))]
    (transduce xf f (int-array MINUTES-PER-DAY) source)))

(defn find-minimum-platforms
  [arrivals departures]
  (->> (calc-trains-by-minute arrivals departures)
       (reduce max)))

(defn -main
  "Run Task 2 with a given input, defaulting to the first example from the
  task description."
  [& args]
  (let [[A D] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (println (find-minimum-platforms A D))))
