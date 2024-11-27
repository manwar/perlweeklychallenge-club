
fun boomerang(a: List<List<Int>>): Boolean {
    var delta = ArrayList<List<Int>>()
    // coincident points
    for (ij in 0 .. 1) {
        for (ik in ij + 1 .. 2) {
            if (a[ij][0] == a[ik][0] && a[ij][1] == a[ik][1]) {
                return false
            }
        }
        delta.add(listOf(a[ij + 1][0] - a[0][0], a[ij + 1][1] - a[0][1]))
    }
    // all on the same vertical line
    if (delta[0][0] == 0 && delta[1][0] == 0) {
        return false
    }
    // just one vertical line
    if (delta[0][0] == 0 || delta[1][0] == 0) {
        return true
    }
    val m = delta[0][1].toFloat() / delta[0][0].toFloat()
    val c = a[0][1].toFloat() - a[0][0].toFloat() * m
    return a[2][1].toFloat() != a[2][0].toFloat() * m + c
}

fun main() {

    if (boomerang(listOf(listOf(1, 1), listOf(2, 3), listOf(3, 2)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!boomerang(listOf(listOf(1, 1), listOf(2, 2), listOf(3, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (boomerang(listOf(listOf(1, 1), listOf(1, 2), listOf(2, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!boomerang(listOf(listOf(1, 1), listOf(1, 2), listOf(1, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!boomerang(listOf(listOf(1, 1), listOf(2, 1), listOf(3, 1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (boomerang(listOf(listOf(0, 0), listOf(2, 3), listOf(4, 5)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
