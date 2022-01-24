fun eban(mx: Int): ArrayList<Int> {
    val units=listOf(true,false,true,false,true,false,true,false,false,false)
    val tens=listOf(true,false,false,true,true,true,true,false,false,false,false)
    var out=ArrayList<Int>()
    for (i in 0..mx) {
        if (tens[(i/10).toInt()] &&
            units[i%10] &&
            i != 0) {
            out.add(i)
        }
    }
    return out
}

fun main() {
  if (eban(100) == listOf(2, 4, 6, 30, 32, 34, 36, 40, 42, 44, 46, 50, 52, 54, 56, 60, 62, 64, 66)) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
