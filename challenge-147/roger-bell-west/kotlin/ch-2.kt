import kotlin.system.exitProcess

fun pentagon(n: Int): Int {
    return n*(3*n-1)/2
}

fun pentpair() {
    var fpent=ArrayList<Int>()
    fpent.add(0)
    var rpent=mutableMapOf<Int,Int>()
    var mx=0
    var a=1
    while (true) {
        while (mx < a) {
            mx += 1
            fpent.add(pentagon(mx))
            rpent.put(fpent[mx],mx)
        }
        for (b in 1..a-1) {
            val d=fpent[a]-fpent[b]
            if (rpent.contains(d)) {
                val s=fpent[a]+fpent[b]
                while (s > fpent[mx]) {
                    mx += 1
                    fpent.add(pentagon(mx))
                    rpent.put(fpent[mx],mx)
                }
                if (rpent.contains(s)) {
                    println("P(%d) + P(%d) = %d + %d = %d = P(%d)".format(a,b,fpent[a],fpent[b],s,rpent[s]))
                    println("P(%d) - P(%d) = %d - %d = %d = P(%d)".format(a,b,fpent[a],fpent[b],d,rpent[d]))
                    exitProcess(0)
                }
            }
        }
        a += 1
    }
}

fun main() {
  pentpair()
}
