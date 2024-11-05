fun permute(aa: List<Int>): ArrayList<List<Int>> {
    var a = ArrayList<Int>()
    for (i in aa) {
        a.add(i)
    }
    var out = ArrayList<List<Int>>()
    val n = a.size
    var c = ArrayList<Int>();
    for (i in 0..n-1) {
        c.add(0)
    }
    out.add(a.toList())
    var i = 0
    while (true) {
        if (i >= n) {
            break
        }
        if (c[i] < i) {
            if (i % 2 == 0) {
                val tmp = a[0]
                a[0] = a[i]
                a[i] = tmp
            } else {
                val tmp = a[c[i]]
                a[c[i]] = a[i]
                a[i] = tmp
            }
            out.add(a.toList())
            c[i] += 1
            i = 0
        } else {
            c[i] = 0
            i += 1
        }
    }
    return out
}

fun nextpermutation(a: List<Int>): List<Int> {
    val b = a.sorted()
    var flag = false
    var out = listOf(0)
    val listComparator = Comparator {
        i: List<Int>, j: List<Int> ->
            var ix = 0
        var res = false
        while (true) {
            if (ix >= i.size && ix >= j.size) {
                break
            }
            if (ix < i.size && ix >= j.size) {
                res = true
                break
            }
            if (ix >= i.size && ix < j.size) {
                res = false
                break
            }
            if (i[ix] != j[ix]) {
                res = i[ix] < j[ix]
                break
            }
            ix += 1
        }
        if (res) {
            -1
        } else {
            1
        }
    }
    for (px in permute(b).sortedWith(listComparator)) {
        if (out.size == 1) {
            out = px
        }
        if (flag) {
            out = px
            flag = false
        }
        if (px == a) {
            flag = true
        }
    }
    return out
}

  fun main() {

    if (nextpermutation(listOf(1, 2, 3)) == listOf(1, 3, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nextpermutation(listOf(2, 1, 3)) == listOf(2, 3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (nextpermutation(listOf(3, 1, 2)) == listOf(3, 2, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
