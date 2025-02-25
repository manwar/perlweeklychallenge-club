fun stepbystep(a: List<Int>): Int {
    var mv = 0
    var tot = 0
    for (s in a) {
        tot += s
        if (mv > tot) {
            mv = tot
        }
    }
    return 1 - mv
}

fun main() {

    if (stepbystep(listOf(-3, 2, -3, 4, 2)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stepbystep(listOf(1, 2)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (stepbystep(listOf(1, -2, -3)) == 5) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
