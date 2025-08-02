
fun sortoddeven(a: List<Int>): List<Int> {
    var odds = ArrayList<Int>()
    var evens = ArrayList<Int>()
    a.forEachIndexed{i, x ->
                         if (i % 2 == 0) {
                             evens.add(x)
                         } else {
                             odds.add(x)
                         }
    }
    evens.sort()
    odds.sort()
    odds.reverse()
    var out = ArrayList<Int>()
    for (i in 0 .. listOf(evens.size, odds.size).maxOrNull()!! - 1) {
        if (i < evens.size) {
            out.add(evens[i])
        }
        if (i < odds.size) {
            out.add(odds[i])
        }
    }
    return out
}

fun main() {

    if (sortoddeven(listOf(4, 1, 2, 3)) == listOf(2, 3, 4, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortoddeven(listOf(3, 1)) == listOf(3, 1)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (sortoddeven(listOf(5, 3, 2, 1, 4)) == listOf(2, 3, 4, 1, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
