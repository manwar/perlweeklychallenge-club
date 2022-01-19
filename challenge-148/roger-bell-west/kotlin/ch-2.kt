fun cardano(ct: Int): ArrayList<List<Int>> {
    var out=ArrayList<List<Int>>()
    var k=0
    var cn=0
    while (true) {
        val a=3*k+2
        val b2c=(k+1)*(k+1)*(8*k+5)
        var b=0
        var b2=0
        var inc=1
        while (true) {
            b += 1
            b2 += inc
            inc += 2
            if (b2 > b2c) {
                break
            }
            if (b2c % b2 == 0) {
                out.add(listOf(a,b,b2c/b2))
                cn += 1
                if (cn >= ct) {
                    break
                }
            }
        }
        if (cn >= ct) {
            break
        }
        k += 1
    }
    return out
}

fun main() {
  if (cardano(5) == listOf(listOf(2,1,5),listOf(5,1,52),listOf(5,2,13),listOf(8,1,189),listOf(8,3,21))) {
    println("Pass")
  } else {
    println("FAIL")
  }
}
