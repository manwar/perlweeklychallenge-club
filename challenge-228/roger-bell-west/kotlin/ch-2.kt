fun emptyarray(a0: List<Int>): Int {
    var t = 0
    var a = a0.toMutableList()
    while (a.size > 0) {
        val mn = a.minOrNull()!!
        for ((i, v) in a.withIndex()) {
            if (v == mn) {
                t += i + 1
                a.removeAt(i)
                break
            }
        }
    }
    return t
}

fun main() {

    if (emptyarray(listOf(3, 4, 2)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (emptyarray(listOf(1, 2, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
