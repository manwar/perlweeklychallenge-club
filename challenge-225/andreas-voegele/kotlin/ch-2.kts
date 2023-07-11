#!/usr/bin/env kotlin

/*
 * You are given an array of integers.  For each element calculate the the
 * sums of the elements to the left and right.  Return the differences between
 * these sums.
 */

fun leftRightSumDiff(ints: IntArray): IntArray {
    val differences = IntArray(ints.size)
    var leftSum = 0
    var rightSum = ints.sum()
    ints.forEachIndexed { i, n ->
        rightSum -= n
        differences[i] = Math.abs(leftSum - rightSum)
        leftSum += n
    }
    return differences
}

println(leftRightSumDiff(intArrayOf(10, 4, 8, 3)).contentToString())
println(leftRightSumDiff(intArrayOf(1)).contentToString())
println(leftRightSumDiff(intArrayOf(1, 2, 3, 4, 5)).contentToString())
