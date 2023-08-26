(ns c231.t1
  (:require
    [clojure.edn :as edn]
    [clojure.pprint :refer [cl-format]]))

(def DEFAULT-INPUT [[3 2 1 4]])

(defn exclude-extrema
  [coll]
  (let [sorted (->> coll (into (sorted-set)) vec)
        chopped (subvec sorted 1 (dec (count sorted)))]
    (if (empty? chopped) -1 chopped)))

(defn -main
  "Run Task 1 with a given input COLL, defaulting to the first example from the
  task description."
  [& args]
  (let [[COLL] (or (some->> args (map edn/read-string)) DEFAULT-INPUT)]
    (cl-format true "(~{~a~^, ~})~%" (exclude-extrema COLL))))
