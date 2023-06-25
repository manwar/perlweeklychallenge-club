#!/usr/bin/env kotlin

/*
 * You are given a list of positive integers, @ints.  Write a script to find
 * the total matching members after sorting the list in increasing order.
 */

fun matchingMembers(ints: List<Int>): List<Int> =
    ints.zip(ints.sorted()).filter { (a, b) -> a == b }.map { (a) -> a }

println(matchingMembers(listOf(1, 1, 4, 2, 1, 3)).size)
println(matchingMembers(listOf(5, 1, 2, 3, 4)).size)
println(matchingMembers(listOf(1, 2, 3, 4, 5)).size)
