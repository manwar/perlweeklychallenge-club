#!/usr/bin/env kotlin

/*
 * You are given a list of sentences.  A sentence is a list of words that are
 * separated by a single space with no leading or trailing spaces.  Write a
 * script to find out the maximum number of words that appear in a single
 * sentence.
 */

fun maxWords(vararg sentences: String): Int =
    sentences.maxOfOrNull { it.split(' ').size } ?: 0

println(
    maxWords(
        "Perl and Raku belong to the same family.",
        "I love Perl.",
        "The Perl and Raku Conference.",
    ),
)

println(
    maxWords(
        "The Weekly Challenge.",
        "Kotlin is the most interesting guest language.",
        "Team PWC has over 300 members.",
    ),
)
