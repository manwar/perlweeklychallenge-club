(ns c171.t2)

; compose is built in as (comp)
(def compose comp)

(defn f [& args] (conj args 'f))
(defn g [& args] (conj args 'g))

(defn -main
  "Run Task 2."
  [& args]
  (let [h (compose f g)]
    (prn (h "Hello" "there."))))
