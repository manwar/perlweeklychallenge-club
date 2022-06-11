(ns c150.t1)

(def DEFAULT-INPUT ["1234" "5678"])
(def SIZE 51)

(defn fibo-words
  [a b]
  (let [p (promise)]
    @(doto p
       (deliver (list* a b (lazy-seq (map str @p (rest @p))))))))

(defn solve
  [source]
  (let [xf (comp (drop-while #(< (count %) SIZE)) (take 1))
        f (completing (fn [_ w] (nth w (dec SIZE))))]
    (->> source
         (transduce xf f nil))))

(defn -main
  [& args]
  (let [[A B] (or args DEFAULT-INPUT)]
    (println (solve (fibo-words A B)))))
