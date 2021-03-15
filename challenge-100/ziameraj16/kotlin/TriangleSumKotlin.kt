import java.util.*
import java.util.stream.Collectors

object TriangleSumKotlin {
    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter number of rows in the triangle")
        val numberOfRows = scanner.nextLine().toInt()
        val list: MutableList<List<Int>?> = ArrayList<List<Int>?>()
        var i = 1
        while (i <= numberOfRows) {
            println("Enter comma separated elements of line $i")
            val rowElements = Arrays.stream(scanner.nextLine().split(",".toRegex()).toTypedArray()).map { s: String? -> Integer.valueOf(s) }.collect(Collectors.toList())
            list.add(rowElements)
            i++
        }
        println("Output: " + triangleSum(list))
    }

    fun triangleSum(list: List<List<Int>?>): Int {
        var sum = 0
        for (row in list) {
            sum += Collections.min(row)
        }
        return sum
    }
}
