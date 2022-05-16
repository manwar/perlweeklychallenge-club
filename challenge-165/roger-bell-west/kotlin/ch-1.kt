fun main() {
    var points = ArrayList<Pair<Int,Int>>()
    var lines = ArrayList<Pair<Pair<Int,Int>,Pair<Int,Int>>>()
    var x = ArrayList<Int>()
    var y = ArrayList<Int>()
    while(true) {
        var line = readLine()
        if (line == null) {
            break
        }
        val f = line.split(",").map {it.toInt()}
        for (i in 0..f.size-1) {
            if (i % 2 == 0) {
                x.add(f[i])
            } else {
                y.add(f[i])
            }
        }
        if (f.size == 4) {
            lines.add(Pair(Pair(f[0],f[1]),Pair(f[2],f[3])))
        } else if (f.size == 2) {
            points.add(Pair(f[0],f[1]))
        }
    }
    val mnx = x.toList().minOrNull()!!
    val mxx = x.toList().maxOrNull()!!
    val mny = y.toList().minOrNull()!!
    val mxy = y.toList().maxOrNull()!!
    val lo = Pair(mnx-(mxx-mnx)/10,mny-(mxy-mny)/10)
    val hi = Pair(mxx+(mxx-mnx)/10,mxy+(mxy-mny)/10)
    val w = hi.first-lo.first
    val h = hi.second-lo.second
    println("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
    println("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.0//EN\" \"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd\">")
    println("<svg width=\"" +
            w.toString() +
            "\" height=\"" +
            h.toString() +
            "\" viewBox=\"" +
            lo.first.toString() +
            " " +
            lo.second.toString() +
            " " +
            w.toString() +
            " " +
            h.toString() +
            "\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">")
    if (lines.size > 0) {
        println("  <g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">")
        for (p in lines) {
            println("    <line x1=\"" +
                    p.first.first.toString() +
                    "\" y1=\"" +
                    p.first.second.toString() +
                    "\" x2=\"" +
                    p.second.first.toString() +
                    "\" y2=\"" +
                    p.second.second.toString() +
                    "\" />")
        }
        println("  </g>")
    }
    if (points.size > 0) {
        println("  <g fill=\"#f73\" id=\"points\">")
        for (p in points) {
            println("    <circle cx=\"" +
                    p.first.toString() +
                    "\" cy=\"" +
                    p.second.toString() +
                    "\" r=\"3\" />")
        }
        println("  </g>")
    }
    println("</svg>")
}
