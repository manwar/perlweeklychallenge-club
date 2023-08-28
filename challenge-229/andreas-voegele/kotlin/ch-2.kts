#!/usr/bin/env kotlin

/*
 * You are given three arrays of integers.  Write a script to return all the
 * elements that are present in at least 2 out of 3 given arrays.
 */

typealias BitSet = Int

infix fun BitSet?.or(other: BitSet) = this?.or(other) ?: other

// We use += as there is no |= operator in Kotlin.
operator fun BitSet?.plus(other: BitSet) = this or other

fun twoOutOfThree(vararg arrays: IntArray): List<Int> {
    val bitSetFor = mutableMapOf<Int, BitSet>()
    arrays.forEachIndexed { i, array ->
        array.forEach {
            bitSetFor[it] += 1 shl i
        }
    }
    return bitSetFor.filterValues { it.countOneBits() > 1 }.keys
        .toList().sorted()
}

println(
    twoOutOfThree(intArrayOf(1, 1, 2, 4), intArrayOf(2, 4), intArrayOf(4)),
)
println(
    twoOutOfThree(intArrayOf(4, 1), intArrayOf(2, 4), intArrayOf(1, 2)),
)
