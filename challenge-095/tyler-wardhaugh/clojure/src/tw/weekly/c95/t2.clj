(ns tw.weekly.c95.t2
  (:require [clojure.edn :as edn]
            [tw.weekly.c95.stack :as stk])
  (:import java.util.Stack))

;;;
; Task description for TASK #2 › Demo Stack
;;;

;;; Example from Task:
; my $stack = Stack->new;
; $stack->push(2);
; $stack->push(-1);
; $stack->push(0);
; $stack->pop;       # removes 0
; print $stack->top; # prints -1
; $stack->push(0);
; print $stack->min; # prints -1
;;;

(defn demo-stack-java
  "Demonstrate using Java's Stack"
  []
  (->>
    (doto (Stack.)
      (.push 2)
      (.push -1)
      (.push 0)
      (.pop)
      (#(println (.peek %)))
      (.push 0))
    (reduce min)
    println))

(defn demo-stack-clj-list
  "Demonstrate using Clojure's list datatype as a stack"
  []
  (->>
    (-> (list)
        (conj 2)
        (conj -1)
        (conj 0)
        (pop)
        ((fn [stack] (println (peek stack)) stack))
        (conj 0))
    (reduce min)
    println))

(defn demo-stack-finger-tree
  "Demonstrate using protocol & a finger tree-backed record"
  []
  (-> (stk/make-stack)
      (.push 2)
      (.push -1)
      (.push 0)
      (.pop)
      ((fn [stack] (println (.top stack)) stack))
      (.push 0)
      (.min)
      println))

(defn -main
  "Run Task 2, demoing stack operations in three different ways."
  [& args]
  (println "java.util.Stack demo:")
  (demo-stack-java)
  (println "Clojure list demo:")
  (demo-stack-clj-list)
  (println "Finger tree-backed record demo")
  (demo-stack-finger-tree))
