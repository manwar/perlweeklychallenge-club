#!/usr/bin/env kotlin

/*
 * You are given an array representing box coins, @box.  Write a script to
 * collect the maximum coins until you took out all boxes.  If we pick box[i]
 * then we collect the coins $box[i-1] * $box[i] * $box[i+1].  If $box[i+1] or
 * $box[i-1] is out of bound then treat it as 1 coin.
 */

fun boxCoins(box: List<Int>): Int = when (box.size) {
    0 -> 0
    1 -> box.first()
    else -> box.foldIndexed(0) { i, total, boxI ->
        val product = when (i) {
            0 -> boxI * box[1]
            box.lastIndex -> box[i - 1] * boxI
            else -> box[i - 1] * boxI * box[i + 1]
        }
        val n = product + boxCoins(box.filterIndexed { j, _ -> j != i })
        if (total > n) total else n
    }
}

println(boxCoins(listOf(3, 1, 5, 8)))
println(boxCoins(listOf(1, 5)))
println(boxCoins(listOf(3, 8, 6, 9, 2, 4, 5, 9, 2)))
