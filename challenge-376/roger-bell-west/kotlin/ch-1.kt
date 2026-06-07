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

fun chessboardsquares(a: String, b: String): Boolean {
    return checkcolor(a) == checkcolor(b)
}

fun main() {

    if (chessboardsquares("a7", "f4")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!chessboardsquares("c1", "e8")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!chessboardsquares("b5", "h2")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (chessboardsquares("f3", "h1")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!chessboardsquares("a1", "g8")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
