fun magicaltriplets(a: List<Int>): List<Int> {
    var out = listOf<Int>()
    var mv = 0
    for (ai in 0..a.size-3) {
        for (bi in ai+1..a.size-2) {
            for (ci in bi+1..a.size-1) {
                if (a[ai] + a[bi] > a[ci] &&
                    a[bi] + a[ci] > a[ai] &&
                    a[ai] + a[ci] > a[bi]) {
                    var v = a[ai] + a[bi] + a[ci]
                    if (v > mv) {
                        mv = v
                        out = listOf(a[ai], a[bi], a[ci])
                    }
                }
            }
        }
    }
    return out.sorted().reversed().toList()
}

fun main() {
    if (magicaltriplets(listOf(1, 2, 3, 2)) ==
            listOf(3, 2, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (magicaltriplets(listOf(1, 3, 2)) ==
            listOf<Int>()) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (magicaltriplets(listOf(1, 1, 2, 3)) ==
            listOf<Int>()) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (magicaltriplets(listOf(2, 4, 3)) ==
            listOf(4, 3, 2)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
