#!/usr/bin/env kotlin

/*
 * You are given a string containing digits 0-9 only.  Write a script to find
 * out if the given string is additive number.  An additive number is a string
 * whose digits can form an additive sequence.
 *
 * A valid additive sequence should contain at least 3 numbers.  Except the
 * first 2 numbers, each subsequent number in the sequence must be the sum of
 * the preceding two.
 */

fun combineDigits(numericString: String): List<List<Int>> =
    (1..numericString.length).flatMap { n ->
        val number = numericString.take(n).toInt()
        val rest = numericString.drop(n)
        if (rest.isEmpty()) {
            listOf(listOf(number))
        }
        else {
            combineDigits(rest).map { listOf(number) + it }
        }
    }

fun isAdditive(numbers: List<Int>): Boolean {
    val size = numbers.size
    if (size < 3) {
        return false
    }
    val triples = sequence {
        for (i in 0..size - 3) {
            yield(Triple(numbers[i], numbers[i + 1], numbers[i + 2]))
        }
    }
    return triples.all { it.first + it.second == it.third }
}

fun isAdditiveNumber(numericString: String) =
    combineDigits(numericString).any { isAdditive(it) }

println(isAdditiveNumber("112358"));
println(isAdditiveNumber("12345"));
println(isAdditiveNumber("199100199"));
