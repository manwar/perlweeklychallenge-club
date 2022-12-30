fun is_wigglesorted(l: List<Int>): Boolean {
    for (i in 0..l.size-2) {
        if (i % 2 == 0) {
            if (l[i] >= l[i+1]) {
                return false
            }
        } else {
            if (l[i] <= l[i+1]) {
                return false
            }
        }
    }
    return true
}

fun wigglesort(l: List<Int>): List<Int> {
    var s = ArrayList(l)
    s.sort()
    val le = s.size
    val p = le / 2
    var a = ArrayList(s.slice(0 .. p - 1))
    var b = ArrayList(s.slice(p .. le - 1))
    var i = 0
    var o = ArrayList<Int>()
    if (le % 2 == 1) {
        o.add(s[p])
        b = ArrayList(s.slice(p + 1 .. le - 1))
        i = 1
    }
    for (j in i .. le - 1) {
        if (j % 2 == 0) {
            o.add(a.removeLast())
        } else {
            o.add(b.removeLast())
        }
    }
    return o.toList()
}

fun main() {
    if (!is_wigglesorted(listOf(1,5,1,1,6,4))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (is_wigglesorted(listOf(1,6,1,5,1,4))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (!is_wigglesorted(listOf(1,3,2,2,3,1))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (is_wigglesorted(listOf(2,3,1,3,1,))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (!is_wigglesorted(listOf(1,3,2,2,3,1))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (is_wigglesorted(wigglesort(listOf(1,5,1,1,6,4)))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (is_wigglesorted(wigglesort(listOf(1,3,2,2,3,1)))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (is_wigglesorted(wigglesort(listOf(1,3,2,2,2,3,1)))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    println("")
}
