(ns tw.weekly.ch-1)

(defn majority
  "Calculate the majority element, which is the element in a list that appears more than floor(size_of_list/2), prefering the least significant digit that matches that criteria. Returns -1 if no such element is found."
  [coll]
  (let [minimum (Math/floor (/ (count coll) 2))
        maj (->> coll
              frequencies
              (filter (comp #(> % minimum) second))
              (sort second)
              ffirst)]
    (or maj -1)))

(defn -main
  "Run Task 1 with a list of integers, defaulting to the sample given in the task description."
  [& args]
  (let [N (if (not-empty args)
            (map clojure.edn/read-string args)
            [2, 2, 2, 3, 2, 4, 2])]
    (println (majority N))))
