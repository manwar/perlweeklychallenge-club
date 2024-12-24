fun largestnumber(a: List<Int>): Int {
    val ax = a.map{it.toString()}.toList()
    val stringComparator = Comparator {
        i: String, j: String ->
                              val ij = (i + j).toInt()
                              val ji = (j + i).toInt()
                              ji - ij
    }
    val ay = ax.sortedWith(stringComparator)
    return ay.joinToString("").toInt()
}

fun main() {
    if (largestnumber(listOf(20, 3)) == 320) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (largestnumber(listOf(3, 30, 34, 5, 9)) == 9534330) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")
}
