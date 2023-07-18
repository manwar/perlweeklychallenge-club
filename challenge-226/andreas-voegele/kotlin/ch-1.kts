#!/usr/bin/env kotlin

/*
 * You are given a string and an integer array of the same length.  The string
 * will be shuffled such that the character at the ith position moves to
 * indices[i] in the shuffled string.  Return the shuffled string.
 */

fun shuffleString(string: String, indices: IntArray): String {
    val chars = CharArray(indices.size)
    for ((i, c) in indices zip string.toList()) {
        chars[i] = c
    }
    return String(chars)
}

println(shuffleString("lacelengh", intArrayOf(3, 2, 0, 5, 4, 8, 6, 7, 1)))
println(shuffleString("rulepark", intArrayOf(4, 7, 3, 1, 0, 5, 2, 6)))
