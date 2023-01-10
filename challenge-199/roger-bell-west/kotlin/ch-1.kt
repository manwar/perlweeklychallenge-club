fun goodpairs(l: List<Int>): Int {
    var c = 0
    var k = mutableMapOf<Int, Int>()
    for (i in l) {
        if (k.containsKey(i)) {
            k[i] = k[i]!!+1
        } else {
            k[i] = 1
        }
    }
    for (v in k.values) {
        c += v * (v - 1)
    }
    return c / 2
}

fun main() {

    if (goodpairs(listOf(1, 2, 3, 1, 1, 3)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodpairs(listOf(1, 2, 3)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodpairs(listOf(1, 1, 1, 1)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
