import kotlin.io.*

fun main() {
    var t = mutableMapOf<String, Int>()
    java.io.File("temperature.txt").forEachLine { line ->
                                                      val l = line.split(",");
                                                  t[l[0]] = l[1].trim().toInt()
    }
    var lt = 999
    for (k in t.keys.sorted()) {
        if (t[k]!! > lt) {
            println(k)
        }
        lt = t[k]!!
    }
}
