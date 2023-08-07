#!/usr/bin/env kotlin

/*
 * You are given an array of integers.  Write a script to find out the sum of
 * unique elements in the given array.  Non-unique elements are ignored.
 */

fun uniqueSum(ints: List<Int>): Int =
    ints.groupingBy { it }.eachCount().filterValues { it == 1 }.keys.sum()

println(uniqueSum(listOf(2, 1, 3, 2)))
println(uniqueSum(listOf(1, 1, 1, 1)))
println(uniqueSum(listOf(2, 1, 3, 4)))
