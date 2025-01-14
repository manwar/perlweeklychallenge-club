fun arrangebinary(a: List<Int>, n: Int): Boolean {
    var b = ArrayList(a)
    var t = n
    for (i in 0 .. b.size - 1) {
        if (b[i] == 0 &&
            (i == 0 || b[i - 1] == 0) &&
            (i == b.size - 1 || b[i + 1] == 0)) {
            b[i] = 1
            t -= 1
        }
    }
    return t <= 0
}

fun main() {

    if (arrangebinary(listOf(1, 0, 0, 0, 1), 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!arrangebinary(listOf(1, 0, 0, 0, 1), 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
