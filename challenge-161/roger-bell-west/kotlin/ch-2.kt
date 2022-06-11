fun main() {
    var f = mutableMapOf<String,Int>()
    var r = mutableMapOf<Int,String>()
    while(true) {
        var line = readLine()
        if (line == null) {
            break
        }
        var b = 1
        var v = 0
        for (l in 'a' .. 'z') {
            if (line.contains(l)) {
                v = v or b
            }
            b = b shl 1
        }
        if (!r.containsKey(v) || r[v]!!.length > line.length) {
            f[line]=v
            r[v]=line
        }
    }

    var w = ArrayList<String>()
    val lt = (1 shl 26) - 1
    var lu = ArrayList<Int>()
    lu.add(0)
    while (lu.last() != lt) {
        var wn = ""
        if (w.size > 0) {
            var mode = 0
            var sc = ArrayList<String>()
            for (wv in r.keys) {
                if ((wv and lu.last()) == 0) {
                    if (mode == 0) {
                        mode = 1
                        sc.clear()
                    }
                    sc.add(r[wv]!!)
                } else if (mode == 0 && (wv or lu.last()) != lu.last()) {
                    sc.add(r[wv]!!)
                }
            }
            if (sc.size == 0) {
                w.removeAt(w.lastIndex)
                lu.removeAt(lu.lastIndex)
            } else {
                wn = sc[(0..sc.lastIndex).random()]
            }
        } else {
            val sc=f.keys.toList()
            wn = sc[(0..sc.lastIndex).random()]
        }
        if (wn != "") {
            w.add(wn)
            lu.add(lu.last() or f[wn]!!)
        }
    }
    println(w.joinToString(" "))
}
