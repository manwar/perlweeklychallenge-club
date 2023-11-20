fun floorsum(a: List<Int>): Int {
    var n = 0
    for (iv in a) {
        for (jv in a) {
            n += iv / jv
        }
    }
    return n
}

fun main() {

    if (floorsum(listOf(2, 5, 9)) == 10) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (floorsum(listOf(7, 7, 7, 7, 7, 7, 7)) == 49) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
