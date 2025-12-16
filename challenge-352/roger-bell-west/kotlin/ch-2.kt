fun binaryprefix(a: List<Int>): List<Boolean> {
    var c = 0
    var out = ArrayList<Boolean>()
    for (n in a) {
        c *= 2
        c += n
        out.add(c % 5 == 0)
    }
    return out
}

fun main() {

    if (binaryprefix(listOf(0, 1, 1, 0, 0, 1, 0, 1, 1, 1)) == listOf(true, false, false, false, false, true, true, false, false, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(1, 0, 1, 0, 1, 0)) == listOf(false, false, true, true, false, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(0, 0, 1, 0, 1)) == listOf(true, true, false, false, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(1, 1, 1, 1, 1)) == listOf(false, false, false, true, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (binaryprefix(listOf(1, 0, 1, 1, 0, 1, 0, 0, 1, 1)) == listOf(false, false, true, false, false, true, true, true, false, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
