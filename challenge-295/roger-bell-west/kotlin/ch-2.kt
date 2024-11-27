import kotlin.math.*

fun jumpgame(a: List<Int>): Int {
    val target = a.size - 1
    var here = mutableSetOf<Int>()
    here.add(0)
    var moves = 0
    while (true) {
        moves += 1
        var there = mutableSetOf<Int>()
        for (n in here) {
            for (i in (n + 1)..min(n + a[n], target)) {
                there.add(i)
            }
            if (there.isEmpty()) {
                return -1
            }
            if (there.contains(target)) {
                return moves
            }
            here = there
        }
    }
}

fun main() {

    if (jumpgame(listOf(2, 3, 1, 1, 4)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (jumpgame(listOf(2, 3, 0, 4)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (jumpgame(listOf(2, 0, 0, 4)) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
