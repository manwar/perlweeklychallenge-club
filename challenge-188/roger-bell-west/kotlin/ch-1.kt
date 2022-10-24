fun divisiblepairs(a: List<Int>, k: Int): Int {
    var ct = 0
    for (ai in 0..a.size-2) {
        for (bi in ai+1..a.size-1) {
            if ((a[ai] + a[bi]) % k == 0) {
                ct += 1
            }
        }
    }
    return ct
}

fun main() {
    if (divisiblepairs(listOf(4, 5, 1, 6), 2) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (divisiblepairs(listOf(1, 2, 3, 4), 2) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (divisiblepairs(listOf(1, 3, 4, 5), 3) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (divisiblepairs(listOf(5, 1, 2, 3), 4) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (divisiblepairs(listOf(7, 2, 4, 5), 4) == 1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
