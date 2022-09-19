fun sparkline(nn: List<Int>): String {
    var bar = ArrayList<Char>();
    for (bc in 9601..9608) {
        bar.add(bc.toChar())
    }
    val mn = nn.minOrNull()!!
    val mx = nn.maxOrNull()!!
    val inscale = mx - mn
    val outscale = bar.size
    var out = ""
    for (v in nn) {
        var va = ((v-mn).toDouble()/inscale.toDouble() * outscale.toDouble()).toInt()
        if (va > outscale - 1) {
            va = outscale - 1
        }
        out += bar[va]
    }
    return out
}

fun main() {
    if (sparkline(listOf(0,100)) == "▁█") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (sparkline(listOf(1, 2, 3, 4, 5, 6, 7, 8)) == "▁▂▃▄▅▆▇█") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
