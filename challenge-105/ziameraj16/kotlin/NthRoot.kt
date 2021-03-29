import kotlin.jvm.JvmStatic
import java.util.*

object NthRoot {
    @JvmStatic
    fun main(args: Array<String>) {
        val scanner = Scanner(System.`in`)
        println("Enter value of N")
        val N = scanner.nextDouble()
        println("Enter value of k")
        val k = scanner.nextInt()
        System.out.printf("%.2f", findNthRoot(N, k))
    }

    fun findNthRoot(N: Double, k: Int): Double {
        return Math.pow(k.toDouble(), 1 / N)
    }
}
