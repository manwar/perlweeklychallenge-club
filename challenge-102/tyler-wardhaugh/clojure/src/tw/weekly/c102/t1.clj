(ns tw.weekly.c102.t1
  (:require [clojure.edn :as edn]
            [clojure.string :as str]
            [clojure.pprint :refer [cl-format]]
            [clj-http.client :as client]))

;;;
; Task description for TASK #1 › Rare Numbers
;;;

(def DEFAULT-INPUT 1)

(def rn-cache "A cache of Rare Numbers" (atom {}))

(defn fetch-rn-cache
  "Fetch Rare Numbers from OEIS and put them into a map for use as a cache."
  [& _]
  (let [source (-> (client/get "https://oeis.org/A035519/b035519.txt")
                   :body
                   str/split-lines)
        xf (map (fn [x] (->> (str/split x #"\s+" 2) second)))]
    (group-by count (sequence xf source))))

(defn rare-numbers
  "Generate Rare Numbers for given size n"
  [n]
  (let [cache (if (empty? @rn-cache) (swap! rn-cache fetch-rn-cache) @rn-cache)]
    (get cache n)))

(defn -main
  "Run Task 1 using a list A, defaulting to the example given in the task
  description."
  [& args]
  (let [N (or (some-> args first edn/read-string) DEFAULT-INPUT)]
    (cl-format true "~a digit~:p: ~#:[<none>~;~:*~{~a~^ ~}~]~%" N (rare-numbers N))))
