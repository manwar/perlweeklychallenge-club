(ns c147.t2
  (:import [java.util Collections]))

(def MAX 5000)

; source: https://oeis.org/A000326
; definition:
;   a(0) = 0, a(1) = 1; for n >= 2, a(n) = 2*a(n-1) - a(n-2) + 3
;   Miklos Kristof, Mar 09 2005
(defn pentagon-numbers
  []
  (let [pents (promise)
        f (fn [n-2 n-1] (+ (- (* 2 n-1) n-2) 3))]
    @(doto pents
       (deliver (list* 0 1 (lazy-seq (map f @pents (rest @pents))))))))

(defn in?
  [n coll]
  (pos? (Collections/binarySearch coll n)))

(defn suitable-pair?
  "Are both n+m and |n-m| pentagonal numbers?"
  [n m pents]
  (and (in? (+ n m) pents) (in? (abs (- n m)) pents) [n m]))

(defn find-suitable-pair
  []
  (let [pents (into [] (comp (drop 1) (take MAX)) (pentagon-numbers))]
    (-> (fn [n] (->> pents (some #(suitable-pair? n % pents))))
        (some pents))))

(defn -main
  [& _]
  (println (find-suitable-pair)))
