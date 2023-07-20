#!/usr/bin/env kotlin

/*
 * You are given an array of non-negative integers.  Write a script to return
 * the minimum number of operations to make every element equal zero.  In each
 * operation, you are required to pick a positive number less than or equal to
 * the smallest element in the array, then subtract that from each positive
 * element in the array.
 */

typealias Operation = Pair<Int, IntArray>

fun zeroArray(ints: IntArray): List<Operation> {
    val operations = mutableListOf<Operation>()
    while (true) {
        val n = ints.filter { it > 0 }.minOrNull() ?: break
        ints.forEachIndexed { i, it -> if (it > 0) ints[i] -= n }
        operations.add(n to ints.copyOf())
    }
    return operations
}

// The number of operations is equal to the number of unique positive numbers.
fun minimumOperations(ints: IntArray): Int =
    ints.distinct().count { it > 0 }

fun printOperations(ints: IntArray) {
    val operations = zeroArray(ints)
    println("Input: @ints = (${ints.joinToString()})")
    println("Output: ${operations.size}")
    operations.forEachIndexed { i, it ->
        println("operation ${i + 1}: pick ${it.first} => (${it.second.joinToString()})")
    }
}

printOperations(intArrayOf(1, 5, 0, 3, 5))
println()
printOperations(intArrayOf(0))
println()
printOperations(intArrayOf(2, 1, 4, 0, 3))
