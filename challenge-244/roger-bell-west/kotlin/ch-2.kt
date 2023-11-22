fun combinations(arr: List<Int>, k: Int): List<List<Int>> {
    var c = ArrayList<Int>()
    for (i in 0 .. k-1) {
        c.add(i)
    }
    c.add(arr.size)
    c.add(0)
    var out = ArrayList<List<Int>>()
    while (true) {
        var inner = ArrayList<Int>()
        for (i in k-1 downTo 0) {
            inner.add(arr[c[i]])
        }
        out.add(inner.toList())
        var j = 0
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j
            j += 1
        }
        if (j >= k) {
            break
        }
        c[j] += 1
    }
    return out.toList()
}

fun grouphero(nums0: List<Int>): Int {
    val nums = nums0.sorted().reversed()
    var sum = 0
    for (l in 1 .. nums.size) {
        for (c in combinations(nums, l)) {
            val h = c.last()
            sum += h * h * c[0]
        }
    }
    return sum
}

fun main() {

    if (grouphero(listOf(2, 1, 4)) == 141) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
