#!/usr/bin/env kotlin

/*
 * Write a script to find all elements that are neither minimum nor maximum in
 * an array of integers.  Print -1 if you can't.
 */

fun minMax(ints: IntArray): Pair<Int, Int> {
    val a = ints.first()
    return ints.drop(1).fold(Pair(a, a)) { (min, max), b ->
        Pair(if (min < b) min else b, if (max > b) max else b)
    }
}

fun neitherMinNorMax(vararg ints: Int): List<Int> {
    val (min, max) = minMax(ints)
    return ints.filter { it != min && it != max }
}

fun toString(ints: List<Int>) =
    if (ints.isEmpty()) "-1" else ints.toString()

println(toString(neitherMinNorMax(3, 2, 1, 4)))
println(toString(neitherMinNorMax(3, 1)))
println(toString(neitherMinNorMax(2, 1, 3)))
