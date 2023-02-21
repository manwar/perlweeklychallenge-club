fun maximumxor(l: List<Int>): Int {
    var m = ArrayList<Int>()
    for (ai in 0..l.size-2) {
        for (bi in ai+1..l.size-1) {
            m.add(l[ai] xor l[bi])
        }
    }
    return m.maxOrNull()!!
}

fun main() {

    if (maximumxor(listOf(1, 2, 3, 4, 5, 6, 7)) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumxor(listOf(2, 4, 1, 3)) == 7) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (maximumxor(listOf(10, 5, 7, 12, 8)) == 15) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
