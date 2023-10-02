fun travelexpenditure(costs: List<Int>, days0: List<Int>): Int {
    val days = ArrayList(days0).sorted()
    val validities = listOf(1, 7, 30)
    var stack = ArrayDeque<Pair<Int, List<Int>>>()
    stack.add(Pair(0, days))
    var cheapest = days.size * costs[0]
    while (stack.size > 0) {
        val c = stack.removeFirst()
        if (c.second.size == 0) {
            if (c.first < cheapest) {
                cheapest = c.first
            }
        } else {
            if (c.first >= cheapest) {
                continue
            }
            val start = c.second[0]
            for (i in 0..2) {
                val ed = start + validities[i] - 1
                var dtd = c.second.filter{it > ed}
                stack.add(Pair(c.first + costs[i], dtd))
            }
        }
    }
    return cheapest
}

fun main() {

    if (travelexpenditure(listOf(2, 7, 25), listOf(1, 5, 6, 7, 9, 15)) == 11) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (travelexpenditure(listOf(2, 7, 25), listOf(1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31)) == 20) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
