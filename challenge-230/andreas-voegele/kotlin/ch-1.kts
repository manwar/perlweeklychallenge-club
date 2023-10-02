#!/usr/bin/env kotlin

/*
 * Write a script to separate an array of integers into single digits.
 */

fun separateDigits(vararg ints: Int) =
    ints.flatMap { it.toString().chunked(1).map(String::toInt) }

println(separateDigits(1, 34, 5, 6))
println(separateDigits(1, 24, 51, 60))
