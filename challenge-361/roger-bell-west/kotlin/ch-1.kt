fun zeckendorfrepresentation (a: Int): List<Int> {
    var fib = ArrayList(listOf(0, 1))
    while (fib[fib.size - 1] <= a) {
        fib.add(fib[fib.size - 1] + fib[fib.size - 2])
    }
    fib = ArrayList(fib.dropLast(1))
    var res = ArrayList<Int>()
    var aw = a
    while (aw > 0) {
        val fl = fib.size - 1
        res.add(fib[fl])
        aw -= fib[fl]
        fib = ArrayList(fib.dropLast(1))
        fib = ArrayList(fib.dropLast(1))
        while (fib[fib.size - 1] > aw) {
            fib = ArrayList(fib.dropLast(1))
        }
    }
    return res.toList()
}

fun main() {

    if (zeckendorfrepresentation(4) == listOf(3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(12) == listOf(8, 3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(20) == listOf(13, 5, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(96) == listOf(89, 5, 2)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (zeckendorfrepresentation(100) == listOf(89, 8, 3)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
