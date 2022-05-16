fun main() {
    var points = ArrayList<List<Int>>()
    while(true) {
        var line = readLine()
        if (line == null) {
            break
        }
        for (pp in line.split(" ")) {
            if (pp.length > 0 && !pp.startsWith(' ')) {
                val px = pp.split(",").map {it.toInt()}
                if (px.size == 2) {
                    println(px[0].toString() +
                            "," +
                            px[1].toString());
                    points.add(px)
                }
            }
        }
    }
    var slope = ArrayList<Double>()
    for (i in 0..points.size-2) {
        for (j in i+1..points.size-1) {
            if (points[i][0] != points[j][0]) {
                slope.add((points[j][1]-points[i][1]).toDouble()/(points[j][0]-points[i][0]).toDouble())
            }
        }
    }
    val m = median(slope)
    val c = median(points.map {it[1] - m * it[0]})
    val x = points.map {it[0]}.toList()
    var l = ArrayList<Int>()
    for (xb in listOf(x.minOrNull()!!,x.maxOrNull()!!)) {
        l.add(xb)
        l.add((xb*m+c).toInt())
    }
    println(l.joinToString(","))
}

fun median(s0: List<Double>): Double {
    var s = s0.sorted()
    return s[s.size/2.toInt()]
}
