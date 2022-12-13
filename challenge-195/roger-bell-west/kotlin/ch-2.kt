fun mostfrequenteven(l: List<Int>): Int {
    var f = mutableMapOf<Int, Int>()
    for (n in l) {
        if (n % 2 == 0) {
            var k = f.getOrDefault(n, 0);
            f.set(n, k + 1);
        }
    }
    if (f.size > 0) {
        val m = f.values.maxOrNull()!!
        var ll = ArrayList(f.keys.filter{f[it] == m})
        ll.sort()
        return ll[0]
    } else {
        return -1
    }
}

fun main() {
    if (mostfrequenteven(listOf(1, 1, 2, 6, 2)) == 2) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (mostfrequenteven(listOf(1, 3, 5, 7)) == -1) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")   
    if (mostfrequenteven(listOf(6, 4, 4, 6, 1)) == 4) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
