import kotlin.math.max

fun collectpoints(a: List<Int>): Int {
    var m = ArrayList<Pair<Int, Int>>()
    var st = 0
    while (st < a.size) {
        val k = a[st]
        var e = st
        while (e < a.size && a[e] == k) {
            e += 1
        }
        m.add(Pair(k, e - st))
        st = e
    }
    var rv = 0
    var stack = ArrayList<Pair<ArrayList<Pair<Int, Int>>, Int>>()
    stack.add(Pair(m, 0))
    while (stack.size > 0) {
        val s = stack.removeLast()
        if (s.first.size == 0) {
            rv = max(rv, s.second)
        } else {
            for (i in 0 .. s.first.size - 1) {
                var ss = Pair(ArrayList(s.first), s.second)
                ss = Pair(ss.first, ss.second + ss.first[i].second * ss.first[i].second)
                ss.first.removeAt(i)
                var j = i
                while (true) {
                    if (j >0 &&
                        j < ss.first.size &&
                        ss.first[j].first == ss.first[j - 1].first) {
                        ss.first[j] = Pair(ss.first[j].first, ss.first[j].second + ss.first[j - 1].second)
                        ss.first.removeAt(j - 1)
                        j -= 1
                    } else {
                        break
                    }
                }
                stack.add(ss)
            }
        }
    }
    return rv
}

fun main() {

    if (collectpoints(listOf(2, 4, 3, 3, 3, 4, 5, 4, 2)) == 23) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (collectpoints(listOf(1, 2, 2, 2, 2, 1)) == 20) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (collectpoints(listOf(1)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (collectpoints(listOf(2, 2, 2, 1, 1, 2, 2, 2)) == 40) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
