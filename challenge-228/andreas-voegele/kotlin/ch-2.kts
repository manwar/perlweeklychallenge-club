#!/usr/bin/env kotlin

/*
 * You are given an array of integers in which all elements are unique.  Write
 * a script to perform the following operations until the array is empty and
 * return the total count of operations.
 *
 * If the first element is the smallest then remove it otherwise move it to the
 * end.
 */

fun emptyArray(ints: List<Int>): Int {
    tailrec fun removeSmallest(count: Int, ints: List<Int>, mins: List<Int>): Int {
        val size = ints.size
        if (size < 2) {
            return count + size
        }
        val tail = ints.subList(1, size)
        val first = ints.first()
        if (first > mins.first()) {
            return removeSmallest(count + 1, tail + first, mins)
        }
        return removeSmallest(count + 1, tail, mins.subList(1, size))
    }
    return removeSmallest(0, ints, ints.sorted())
}

println(emptyArray(listOf(3, 4, 2)))
println(emptyArray(listOf(1, 2, 3)))
