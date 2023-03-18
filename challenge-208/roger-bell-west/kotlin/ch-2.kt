fun duplicateandmissing(a: List<Int>): List<Int> {
    var flags = 0
    var dup = 0
    var mis = 0
    var exp = a[0] + 1
    for (n in a.drop(1)) {
        if (n < exp) {
            dup = n
            flags = flags or 1
        } else if (n > exp) {
            mis = exp
            flags = flags or 2
        }
        if (flags == 3) {
            return listOf(dup, mis)
        }
        exp = n + 1
    }
    if (flags == 1) {
        return listOf(dup, exp)
    }
    return listOf(-1)
}

fun main() {

    if (duplicateandmissing(listOf(1, 2, 2, 4)) == listOf(2, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateandmissing(listOf(1, 2, 3, 4)) == listOf(-1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (duplicateandmissing(listOf(1, 2, 3, 3)) == listOf(3, 4)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
