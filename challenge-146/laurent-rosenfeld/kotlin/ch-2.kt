fun find_parent(pair: IntArray): IntArray {
    val num = pair[0]
    val denom = pair[1]
    return if (num < denom) intArrayOf(num, denom - num) else intArrayOf(num - denom, denom)
}

fun n2str (pair: IntArray): String {
    return "${pair[0]}/${pair[1]}"
}

fun main() {
val tests  = arrayOf(intArrayOf(5,2), intArrayOf(2,5), intArrayOf(3,4))
    for (test in tests) {
        val parent = find_parent(test)
        val gd_parent = find_parent(parent)
        print(n2str(test) + " - Parent: " + n2str(parent))
        println(" - Grand-parent: " + n2str(gd_parent))
    }
}
