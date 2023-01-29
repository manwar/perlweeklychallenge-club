fun pennypiles(n: Int): Int {
    if (n == 0) {
        return 1
    }
    var s = 0
    var j = n - 1
    var k = 2
    while (j >= 0) {
        val t = pennypiles(j)
        if ((k / 2) % 2 == 1) {
            s += t
        } else {
            s -= t
        }
        if (k % 2 == 1) {
            j -= k
        } else {
            j -= k / 2
        }
        k += 1
    }
    return s
}

fun main() {

    if (pennypiles(5) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (pennypiles(10) == 42) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
