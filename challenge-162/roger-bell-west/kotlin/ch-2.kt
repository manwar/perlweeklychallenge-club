fun posmod(a: Int, b: Int): Int {
    var m = a % b
    while (m < 0) {
        m = m + b
    }
    return m
}

fun playfair(dir: Int, kwi0: String, input: String): String {
    var kw = ""
    var k = mutableMapOf<Char, Boolean>()
    val re = "[^a-z]+".toRegex()
    val rej = "j".toRegex()
    val kwi = kwi0.lowercase().replace(re,"") + ('a'..'z').joinToString("")
    for (char0 in kwi.toCharArray().toList()) {
        var char = char0
        if (char == 'j') {
            char = 'i'
        }
        if (!k.contains(char)) {
            k[char] = true
            kw = kw + char
        }
    }
    var grid = ArrayList<ArrayList<Char>>()
    var gc = mutableMapOf<Char,Pair<Int,Int>>()
    var index = 0
    for (row in 0..4) {
        var r = ArrayList<Char>()
        for (column in 0..4) {
            r.add(kw.get(index))
            gc[kw.get(index)] = Pair(row,column)
            index = index + 1
        }
        grid.add(r)
    }
    val ii = input.lowercase().replace(re,"").replace(rej,"i")
    var out = ""
    index = 0
    while (index < ii.length) {
        val ca = ii.get(index)
        var cb = 'x'
        if (index + 1 < ii.length) {
            cb = ii.get(index+1)
        }
        index = index + 2
        if (ca == cb) {
            cb = 'x'
            index = index - 1
        }
        val (car,cac) = gc[ca]!!
        val (cbr,cbc) = gc[cb]!!
        var oar = car
        var oac = cac
        var obr = cbr
        var obc = cbc
        if (car == cbr) {
            oac = posmod(cac + dir, 5)
            obc = posmod(cbc + dir, 5)
        } else if (cac == cbc) {
            oar = posmod(car + dir, 5)
            obr = posmod(cbr + dir, 5)
        } else {
            oac = cbc
            obc = cac
        }
        out = out + grid[oar][oac]
        out = out + grid[obr][obc]
    }
    return out
}

fun encrypt(kw: String,plaintext: String): String {
    return playfair(1,kw,plaintext)
}

fun decrypt(kw: String,ciphertext: String): String {
    return playfair(-1,kw,ciphertext)
}

fun main() {
    if (encrypt("playfair example","hide the gold in the tree stump") ==
            "bmodzbxdnabekudmuixmmouvif") {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    if (decrypt("perl and raku","siderwrdulfipaarkcrw") ==
            "thewexeklychallengex") {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
