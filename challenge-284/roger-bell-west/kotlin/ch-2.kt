fun relativesort(list1: List<Int>, list2: List<Int>): List<Int> {
    var c = mutableMapOf<Int, Int>().withDefault({0})
    for (p in list1) {
        c.set(p, c.getValue(p) + 1)
    }
    var out = ArrayList<Int>()
    for (i in list2) {
        out.addAll(List(c.getValue(i)){i})
        c.remove(i)
    }
    var d = c.keys.sorted()
    for (i in d) {
        out.addAll(List(c.getValue(i)){i})
    }
    return out.toList()
}
                       
fun main() {

    if (relativesort(listOf(2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5), listOf(2, 1, 4, 3, 5, 6)) == listOf(2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (relativesort(listOf(3, 3, 4, 6, 2, 4, 2, 1, 3), listOf(1, 3, 2)) == listOf(1, 3, 3, 3, 2, 2, 4, 4, 6)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (relativesort(listOf(3, 0, 5, 0, 2, 1, 4, 1, 1), listOf(1, 0, 3, 2)) == listOf(1, 1, 1, 0, 0, 3, 2, 4, 5)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
