
fun semiorderedpermutation(a: List<Int>): Int {
    val en = a.size
    var s = 1
    var e = en - 1
    a.forEachIndexed {i, n ->
        if (n == 1) {
            s = i
        }
        if (n == en) {
            e = i
        }
    }
    var r = s + (en - 1 - e)
    if (s > e) {
        r -= 1
    }
    return r
}

fun main() {

    if (semiorderedpermutation(listOf(2, 1, 4, 3)) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (semiorderedpermutation(listOf(2, 4, 1, 3)) == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (semiorderedpermutation(listOf(1, 3, 2, 4, 5)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
