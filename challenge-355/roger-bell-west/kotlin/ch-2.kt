fun mountainarray(a: List<Int>): Boolean {
    var state = 0
    for (b in a.windowed(size = 2)) {
        if (b[1] > b[0]) {
            if (state == 0 || state == 1) {
                state = 1
            } else {
                return false
            }
        } else if (b[1] < b[0]) {
            if (state == 1 || state == 2) {
                state = 2
            } else {
                return false
            }
        } else {
            return false
        }
    }
    return state == 2
}

fun main() {

    if (!mountainarray(listOf(1, 2, 3, 4, 5))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mountainarray(listOf(0, 2, 4, 6, 4, 2, 0))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!mountainarray(listOf(5, 4, 3, 2, 1))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!mountainarray(listOf(1, 3, 5, 5, 4, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mountainarray(listOf(1, 3, 2))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
