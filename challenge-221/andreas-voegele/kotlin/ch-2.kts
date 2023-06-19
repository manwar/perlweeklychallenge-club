#!/usr/bin/env kotlin

/*
 * You are given an array of integers, @ints.  Write a script to find the
 * length of the longest Arithmetic Subsequence in the given array.  A
 * subsequence is an array that can be derived from another array by deleting
 * some or none elements without changing the order of the remaining elements.
 * A subsequence is arithmetic if ints[i + 1] - ints[i] are all the same value
 * (for 0 <= i < ints.length - 1).
 */

typealias Ints = List<Int>

fun nextNumbers(acc: MutableList<Int>, distance: Int, ints: Ints): Ints {
    var a = acc.last()
    for (b in ints) {
        if (Math.abs(a - b) == distance) {
            acc.add(b);
            a = b
        }
    }
    return acc
}

tailrec fun subsequences(acc: MutableList<Ints>, ints: Ints): List<Ints> {
    if (ints.size >= 2) {
        val a = ints.first()
        val tail = ints.drop(1)
        tail.forEachIndexed({ i, b ->
            val distance = Math.abs(a - b)
            acc.add(nextNumbers(mutableListOf(a, b), distance, tail.drop(i + 1)))
        })
        return subsequences(acc, tail)
    }
    return acc
}

fun arithmeticSubsequences(ints: Ints): List<Ints> =
    subsequences(mutableListOf<Ints>(), ints)

fun longestLength(sequences: List<Ints>): Int =
    sequences.reduce { a, b -> if (a.size > b.size) a else b }.size

println(longestLength(arithmeticSubsequences(listOf(9, 4, 7, 2, 10))))
println(longestLength(arithmeticSubsequences(listOf(3, 6, 9, 12))))
println(longestLength(arithmeticSubsequences(listOf(20, 1, 15, 3, 10, 5, 8))))
