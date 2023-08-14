#!/usr/bin/env kotlin

/*
 * You are given a list of strings.  Write a script to delete elements that are
 * not lexicographically sorted (forwards or backwards) and return the count of
 * deletions.
 */

tailrec fun isOrderedAscending(s: String): Boolean =
    when {
        s.length < 2 -> true
        s[0] > s[1] -> false
        else -> isOrderedAscending(s.drop(1))
    }

tailrec fun isOrderedDescending(s: String): Boolean =
    when {
        s.length < 2 -> true
        s[0] < s[1] -> false
        else -> isOrderedDescending(s.drop(1))
    }

tailrec fun isOrdered(s: String): Boolean =
    when {
        s.length < 2 -> true
        s[0] < s[1] -> isOrderedAscending(s.drop(1))
        s[0] > s[1] -> isOrderedDescending(s.drop(1))
        else -> isOrdered(s.drop(1))
    }

val stringLists = arrayOf(
    listOf("abc", "bce", "cae"),
    listOf("yxz", "cba", "mon"),
)
for (strings in stringLists) {
    println(strings.size - strings.filter(::isOrdered).size)
}
