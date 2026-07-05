fun reversedegree(a: String): Int {
    var t = 0
    val z0 = 'z'.code + 1
    a.toList().forEachIndexed {i, c ->
        t += (z0 - c.code) * (i + 1)
    }
    return t
}

fun main() {

    if (reversedegree("z") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversedegree("a") == 26) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversedegree("bbc") == 147) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversedegree("racecar") == 560) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (reversedegree("zyx") == 14) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
