#!/usr/bin/env kotlin

/*
 * You are given two strings, $source and $target.  Write a script to find out
 * if using the characters (only once) from source, a target string can be
 * created.
 */

fun countChars(string: String): Map<Char, Int> =
    string.groupBy { it }.map { (char, chars) -> char to chars.size }.toMap()

fun isSpecialNote(source: String, target: String): Boolean {
    val sourceCountFor = countChars(source)
    for ((char, targetCount) in countChars(target)) {
        if (sourceCountFor.getOrDefault(char, 0) < targetCount) {
            return false
        }
    }
    return true
}

println(isSpecialNote("abc", "xyz"))
println(isSpecialNote("scriptinglanguage", "perl"))
println(isSpecialNote("aabbcc", "abc"))
