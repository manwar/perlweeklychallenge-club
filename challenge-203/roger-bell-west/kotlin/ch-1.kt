fun specialquads(l: List<Int>): Int {
    var ct = 0
    for (ai in 0..l.size-4) {
        for (bi in ai+1..l.size-3) {
            for (ci in bi+1..l.size-2) {
                for (di in ci+1..l.size-1) {
                    if (l[ai] + l[bi] + l[ci] == l[di]) {
                        ct += 1
                    }
                }
            }
        }
    }
    return ct
}

fun main() {

    if (specialquads(listOf(1, 2, 3, 6)) == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialquads(listOf(1, 1, 1, 3, 5)) == 4) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (specialquads(listOf(3, 3, 6, 4, 5)) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
