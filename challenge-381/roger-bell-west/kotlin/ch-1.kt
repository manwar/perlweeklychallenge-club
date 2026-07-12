fun samerowcolumn(a: List<List<Int>>): Boolean {
    for (row in a) {
        var notfound = (1 .. row.size).toMutableSet()
        for (n in row) {
            notfound.remove(n)
        }
        if (notfound.size > 0) {
            return false
        }
    }
    for (coln in 0 .. a[0].size - 1) {
        var notfound = (1 .. a.size).toMutableSet()
        for (row in a) {
            notfound.remove(row[coln])
        }
        if (notfound.size > 0) {
            return false
        }
    }
    return true
}

fun main() {

    if (samerowcolumn(listOf(listOf(1, 2, 3, 4), listOf(2, 3, 4, 1), listOf(3, 4, 1, 2), listOf(4, 1, 2, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (samerowcolumn(listOf(listOf(1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!samerowcolumn(listOf(listOf(1, 2, 5), listOf(5, 1, 2), listOf(2, 5, 1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!samerowcolumn(listOf(listOf(1, 2, 3), listOf(1, 2, 3), listOf(1, 2, 3)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!samerowcolumn(listOf(listOf(1, 2, 3), listOf(3, 1, 2), listOf(3, 2, 1)))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
