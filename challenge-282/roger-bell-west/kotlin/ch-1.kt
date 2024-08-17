fun goodinteger(a: Int): Int {
    val winsize = 3
    val d = a.toString().toList()
    d.windowed(size = winsize).forEachIndexed{offset, cc ->
                                                  if (cc[0] == cc[1] && cc[1] == cc[2]) {
                                                      if ((offset == 0 || d[offset- 1] != cc[0]) &&
                                                           (offset == d.size - winsize || d[offset + winsize] != cc[2])) {
                                                          return cc.joinToString("").toInt()
                                                      }
                                                  }
    }
    return -1
}

fun main() {
    if (goodinteger(12344456) == 444) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodinteger(1233334) == -1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (goodinteger(10020003) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
