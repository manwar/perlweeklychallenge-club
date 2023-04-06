fun numbercollision(aa: List<Int>): List<Int> {
    var a = aa
    var dirty = true
    while (dirty) {
        var b = ArrayList<Int>()
        dirty = false
        var i = 0
        while (i + 1 <= a.size) {
            if (i + 1 < a.size &&
                a[i] > 0 &&
                a[i + 1] < 0) {
                val ab = Math.abs(a[i + 1])
                if (a[i] > ab) {
                    b.add(a[i])
                } else if (a[i] < ab) {
                    b.add(a[i + 1])
                }
                i += 2
                dirty = true
            } else {
                b.add(a[i])
                i += 1
            }
        }
        a = b.toList()
    }
    return a
}

fun main() {

    if (numbercollision(listOf(2, 3, -1)) == listOf(2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (numbercollision(listOf(3, 2, -4)) == listOf(-4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (numbercollision(listOf(1, -1)) == emptyList<Int>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
