fun thirtythreepercentappearance(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (n in a) {
        c.set(n, c.getValue(n) + 1)
    }
    var threshold = a.size * 33 / 100
    if (threshold * 100 / 33 != a.size) {
        threshold += 1
    }
    val s = c.keys.toList().filter {c.getValue(it) >= threshold}
    if (s.size == 0) {
        return -1
    }
    return s.sorted()[0]
}

fun main() {

    if (thirtythreepercentappearance(listOf(1, 2, 3, 3, 3, 4, 2)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirtythreepercentappearance(listOf(1, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirtythreepercentappearance(listOf(1, 2, 3)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
