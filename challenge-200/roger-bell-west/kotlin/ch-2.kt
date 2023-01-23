fun sevensegment(l: Int) {
    val disp = listOf(0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x67)
    var v = ArrayList<Int>()
    if (l == 0) {
        v.add(0)
    } else {
        var ll = l
        while (ll > 0) {
            v.add(ll % 10)
            ll /= 10
        }
        v.reverse()
    }
    var d = ArrayList<MutableList<Char>>()
    for (r in 1..7) {
        d.add(MutableList(6*v.size) {_ -> ' '} )
    }
    v.forEachIndexed {i, vv ->
        val x = 6 * i
        val da = disp[vv]
        if (da and 1 > 0) {
            for (xa in x+1..x+3) {
                d[0][xa] = '#'
            }
        }
        if (da and 2 > 0) {
            for (y in 1..2) {
                d[y][x+4] = '#'
            }
        }
        if (da and 4 > 0) {
            for (y in 4..5) {
                d[y][x+4] = '#'
            }
        }
        if (da and 8 > 0) {
            for (xa in x+1..x+3) {
                d[6][xa] = '#'
            }
        }
        if (da and 16 > 0) {
            for (y in 4..5) {
                d[y][x] = '#'
            }
        }
        if (da and 32 > 0) {
            for (y in 1..2) {
                d[y][x] = '#'
            }
        }
        if (da and 64 > 0) {
            for (xa in x+1..x+3) {
                d[3][xa] = '#'
            }
        }
    }
    for (r in d) {
        println(r.joinToString(""))
    }
    
}

fun main() {
    sevensegment(1234567890)
    sevensegment(200)
}
