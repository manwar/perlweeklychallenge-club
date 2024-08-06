fun cs2xy(a: String): Pair<Int, Int> {
    val c = a.toList()
    val x = c[0].code - 'a'.code
    val y = c[1].code - '1'.code
    return Pair(x, y)
}

fun checkcolor(a: String): Boolean {
    val xy = cs2xy(a)
    return (xy.first + xy.second) % 2 == 1
}

fun main() {

    if (checkcolor("d3")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!checkcolor("g5")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (checkcolor("e6")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
