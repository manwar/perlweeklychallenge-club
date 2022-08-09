fun damm(n: Int): Int {
    val tab = arrayOf(
        arrayOf(0,3,1,7,5,9,8,6,4,2),
        arrayOf(7,0,9,2,1,5,4,8,6,3),
        arrayOf(4,2,0,6,8,7,1,3,5,9),
        arrayOf(1,7,5,0,9,8,3,4,2,6),
        arrayOf(6,1,2,3,0,4,5,9,7,8),
        arrayOf(3,6,7,4,2,0,9,5,8,1),
        arrayOf(5,8,6,9,7,2,0,1,3,4),
        arrayOf(8,9,4,5,3,6,2,0,1,7),
        arrayOf(9,4,3,8,6,1,7,2,0,5),
        arrayOf(2,5,8,1,4,3,6,7,9,0)
    )
    var c = 0
    for (digit in n.toString().toCharArray()) {
        val dd = digit.toString().toInt()
        c = tab[c][dd]
    }
    return c
}

fun checkdamm(n: Int): Boolean {
    return damm(n)==0
}

fun main() {
    if (checkdamm(5724)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")
    
    if (!checkdamm(5727)) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")
}
