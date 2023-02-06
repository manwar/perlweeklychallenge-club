fun consecutiveodds(a: List<Int>): Boolean {
    var i = 0
    for (v in a) {
        if (v % 2 == 1) {
            i += 1
            if (i >= 3) {
                return true
            }
        } else {
            i = 0
        }
    }
    return false
}

fun main() {

    if (consecutiveodds(listOf(1, 5, 3, 6))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!consecutiveodds(listOf(2, 6, 3, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!consecutiveodds(listOf(1, 2, 3, 4))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (consecutiveodds(listOf(2, 3, 5, 7))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
