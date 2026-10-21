fun trionicarray(a: List<Int>): Boolean {
    var state = 0
    var prev = a[0]
    for (n in a.drop(1)) {
        var dir = 0
        if (n > prev) {
            dir = 1
        } else if (n < prev) {
            dir = -1
        }
        if (dir == 0) {
            return false
        } else {
            when(state) {
                0 -> {
                    if (dir == 1) {
                        state = 1
                    } else {
                        return false
                    }
                }
                1 -> {
                    if (dir == -1) {
                        state = 2
                    }
                }
                2 -> {
                    if (dir == 1) {
                        state = 3
                    }
                }
                3 -> {
                    if (dir == -1) {
                        return false
                    }
                }
                else -> {
                    return false
                }
            }
            prev = n
        }
    }
    return state == 3
}

fun main() {

    if (trionicarray(listOf(1, 3, 5, 4, 2, 6, 8))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!trionicarray(listOf(1, 4, 4, 2, 1, 3, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (trionicarray(listOf(2, 10, 3, 1, 9))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!trionicarray(listOf(1, 2, 3, 4, 3, 2, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!trionicarray(listOf(1, 3, 2, 4, 1, 5, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
