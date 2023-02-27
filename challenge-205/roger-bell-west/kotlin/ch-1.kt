fun thirdhighest(l: List<Int>): Int {
    var v = ArrayList(l.toSet())
    v.sort()
    v.reverse()
    if (v.size == 0) {
        return 0
    } else if (v.size <= 2) {
        return v[0]
    } else {
        return v[2]
    }
}

fun main() {

    if (thirdhighest(listOf(5, 3, 4)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirdhighest(listOf(5, 6)) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (thirdhighest(listOf(5, 4, 4, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
