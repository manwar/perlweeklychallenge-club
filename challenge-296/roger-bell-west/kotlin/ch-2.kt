fun matchsticksquare(a: List<Int>): Boolean {
    val perimeter = a.sum()
    var sidesleft = 4
    if (perimeter % 4 != 0) {
        return false
    }
    var side = perimeter / 4
    var ss = a.sorted().reversed()
    var lengthleft = side
    while (true) {
        var leftover = ArrayList<Int>()
        for (m in ss) {
            if (m > side) {
                return false
            }
            if (m <= lengthleft) {
                lengthleft -= m
                if (lengthleft == 0) {
                    sidesleft -= 1
                    lengthleft = side
                }
            } else {
                leftover.add(m)
            }
        }
        if (leftover.size == 0) {
            break
        }
        ss = leftover.toList()
    }
    return sidesleft == 0 && lengthleft == side
}

fun main() {

    if (matchsticksquare(listOf(1, 2, 2, 2, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!matchsticksquare(listOf(2, 2, 2, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!matchsticksquare(listOf(2, 2, 2, 2, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (matchsticksquare(listOf(3, 4, 1, 4, 3, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
