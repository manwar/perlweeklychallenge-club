#!/usr/bin/env kotlin

/*
 * Write a script to return the count of words that start with a given prefix.
 */

fun filterWords(prefix: String, vararg words: String) =
    words.filter { it.startsWith(prefix) }

println(filterWords(prefix = "at", "pay", "attention", "practice", "attend").size)
println(filterWords(prefix = "ja", "janet", "julia", "java", "javascript").size)
