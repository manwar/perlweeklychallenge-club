import kotlin.io.*

fun hexwords(lo: Int, hi: Int, sb: Int): List<String> {
    var out = ArrayList<String>()
    java.io.File("dictionary.txt").forEachLine { line ->
                                                     if (line.length >= lo && line.length <= hi) {
                                                         var valid = true
                                                         var sbc = 0
                                                         for (c in line.toCharArray().toList()) {
                                                             if (c == 'o' || c == 'i' || c == 'l' || c == 's' || c == 't') {
                                                                 sbc += 1
                                                                 if (sbc > sb) {
                                                                     valid = false
                                                                 }
                                                             } else if (c < 'a' || c > 'f') {
                                                                 valid = false
                                                             }
                                                             if (!valid) {
                                                                 break
                                                             }
                                                         }
                                                         if (valid) {
                                                             out.add(line)
                                                         }
                                                     }
    }
    return out
}

fun combiwords(wl: List<String>, l: Int): List<String> {
    var wh = mutableMapOf<Int,ArrayList<String>>()
    for (w in wl) {
        if (!wh.containsKey(w.length)) {
            wh[w.length] = ArrayList<String>()
        }
        wh[w.length]!!.add(w)
    }
    var tmap = ArrayList<ArrayList<Int>>()
    tmap.add(ArrayList<Int>())
    var omap = ArrayList<ArrayList<Int>>()
    while (tmap.size > 0) {
        var c = tmap.removeLast()
        val s = c.sum()
        val ls = l - s
        for (j in 1..ls-1) {
            if (wh.containsKey(j)) {
                var cc = ArrayList(c)
                cc.add(j)
                tmap.add(cc)
            }
        }
        if (wh.containsKey(ls)) {
            c.add(ls)
            omap.add(c)
        }
    }
    var out = ArrayList<String>()
    for (pat in omap) {
        var c = ArrayList<Int>()
        var cm = ArrayList<Int>()
        for (i in pat) {
            cm.add(wh[i]!!.size-1)
            c.add(0)
        }
        var ex = false
        while (!ex) {
            var o = ArrayList<String>()
            for (i in 0..c.size-1) {
                o.add(wh[pat[i]]!![c[i]])
            }
            out.add(o.joinToString(""))
            var ss = c.size-1
            while (true) {
                c[ss] += 1
                if (c[ss] > cm[ss]) {
                    if (ss == 0) {
                        ex = true
                        break
                    }
                    c[ss] = 0
                    ss--
                } else {
                    break
                }
            }
        }
    }
    return out
}

fun main() {
    if (hexwords(2,8,8).size == 1463) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (hexwords(8,8,8).size == 164) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (hexwords(2,8,0).size == 45) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (hexwords(2,8,1).size == 244) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (combiwords(hexwords(4,4,0),8).size == 144) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if (combiwords(hexwords(3,5,0),8).size == 274) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
