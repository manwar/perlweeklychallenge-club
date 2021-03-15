import java.util.*

object OriginContainingTriangleKotlin {

    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter first coordinates")
        val firstCoordinate = scanner.nextLine().split(",").map { it.toInt() }.toTypedArray()
        println("Enter second coordinates")
        val secondCoordinate = scanner.nextLine().split(",").map { it.toInt() }.toTypedArray()
        println("Enter third coordinates")
        val thirdCoordinate = scanner.nextLine().split(",").map { it.toInt() }.toTypedArray()
        println("Output: " + doesTriangleContainsOrigin(firstCoordinate[0], firstCoordinate[1], secondCoordinate[0], secondCoordinate[1], thirdCoordinate[0], thirdCoordinate[1]))
    }

    fun doesTriangleContainsOrigin(x1: Int, y1: Int, x2: Int, y2: Int, x3: Int, y3: Int): Int {
        val area = Math.abs((x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2)) / 2.0)
        val area1 = Math.abs((x2 * y3 + x3 * -y2) / 2.0)
        val area2 = Math.abs((x1 * -y3 + x3 * y1) / 2.0)
        val area3 = Math.abs((x1 * y2 + x2 * -y1) / 2.0)
        val aumOfAreaOfSmallTriangles = area1 + area2 + area3
        return if (area == aumOfAreaOfSmallTriangles) 1 else 0
    }
}
