fun uniquenumber(a: List<Int>): Int {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (p in a) {
        c.set(p, c.getValue(p) + 1)
    }
    for (p in c.keys) {
        if (c.getValue(p) == 1) {
            return p
        }
    }
    return -1
}

fun main() {

    if (uniquenumber(listOf(3, 3, 1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquenumber(listOf(3, 2, 4, 2, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquenumber(listOf(1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (uniquenumber(listOf(4, 3, 1, 1, 1, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
