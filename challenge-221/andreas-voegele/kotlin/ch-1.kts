#!/usr/bin/env kotlin

/*
 * You are given a list of @words and a string $chars.  A string is good if it
 * can be formed by characters from $chars, each character can be used only
 * once.  Write a script to return the sum of lengths of all good strings in
 * words.
 */

typealias CharFrequency = Map<Char, Int>

fun String.toCharFrequency() = this.toList().groupingBy { it }.eachCount()

fun CharFrequency.isSubset(superset: CharFrequency) =
    this.all { (char, count) -> count <= superset.getOrDefault(char, 0) }

fun goodStrings(chars: String, words: List<String>): List<String> {
    val validChars = chars.toCharFrequency()
    return words.filter { it.toCharFrequency().isSubset(validChars) }
}

fun sumOfLengths(words: List<String>) = words.map { it.count() }.sum()

println(sumOfLengths(goodStrings("atach", listOf("cat", "bt", "hat", "tree"))))
println(sumOfLengths(goodStrings("welldonehopper", listOf("hello", "world", "challenge"))))
