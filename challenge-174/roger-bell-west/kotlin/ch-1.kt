import kotlin.math.*

fun disarium(ct: Int): List<Int> {
    var o = ArrayList<Int>()
    var pows = ArrayList<ArrayList<Int>>()
    pows.add(ArrayList(listOf(1,1,1,1,1,1,1,1,1,1)))
    var c = 0
    while (true) {
        var disar = 0
        if (c > 0) {
            var ca = c
            var cl = ArrayList<Int>()
            var tx = 0
            while (ca > 0) {
                tx += 1
                cl.add(ca % 10)
                ca /= 10
            }
            cl.reverse()
            if (tx >= pows.size) {
                for (power in pows.size..tx) {
                    var row = ArrayList<Int>()
                    for (digit in 0..9) {
                        row.add(pows[power-1][digit] * digit)
                    }
                    pows.add(row)
                }
            }
            for (i in 0..cl.size-1) {
                disar += pows[i+1][cl[i]]
            }
        }
        if (disar == c) {
            o.add(c)
            if (o.size >= ct) {
                break
            }
        }
        c += 1
    }
    return o
}

fun main() {
    if (disarium(19) == listOf(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135,
                               175, 518, 598, 1306, 1676, 2427, 2646798)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
