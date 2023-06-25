#!/usr/bin/env kotlin

/*
 * You are given an array of positive integers, @ints.  Write a script to find
 * the last member if found otherwise return 0.  Each turn pick the two
 * biggest members (x, y) then decide based on the following conditions,
 * continue this until you are left with one member or none.
 *
 * a) if x == y then remove both members
 *
 * b) if x != y then remove both members and add new member (y - x)
*/

tailrec fun lastMember(ints: List<Int>): Int {
    val sortedInts = ints.sortedByDescending { it }
    val size = sortedInts.size
    if (size > 0) {
        val x = sortedInts.first()
        if (size > 1) {
            val y = sortedInts.component2()
            val rest = sortedInts.drop(2)
            val Δ = Math.abs(y - x)
            if (Δ != 0) {
                return lastMember(listOf(Δ) + rest)
            }
            return lastMember(rest)
        }
        return x
    }
    return 0
}

println(lastMember(listOf(2, 7, 4, 1, 8, 1)))
println(lastMember(listOf(1)))
println(lastMember(listOf(1, 1)))
