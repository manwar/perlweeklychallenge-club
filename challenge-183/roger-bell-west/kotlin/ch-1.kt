fun stringify(n: List<Int>): String {
    return n.map{v -> v.toString()}.joinToString(",")
}

fun uniquearray(n: List<List<Int>>): List<List<Int>> {
    var o = ArrayList<List<Int>>()
    var oh = mutableSetOf<String>()
    for (i in n) {
        val ti = stringify(i)
        if (!oh.contains(ti)) {
            o.add(i)
            oh.add(ti)
        }
    }
    return o.toList()
}

fun main() {
    if (uniquearray(listOf(listOf(1,2), listOf(3,4), listOf(5,6),
                           listOf(1,2))) ==
            listOf(listOf(1,2), listOf(3,4), listOf(5,6))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (uniquearray(listOf(listOf(9,1), listOf(3,7), listOf(2,5),
                           listOf(2,5))) ==
            listOf(listOf(9,1), listOf(3,7), listOf(2,5))) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
