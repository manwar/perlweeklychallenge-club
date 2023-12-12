  fun mostfrequentletterpair(s: String): String {
    var f = mutableMapOf<String, Int>()
    for ( i in 0 .. s.length - 2 ) {
      val ss = s.substring(i,i + 2)
      var nv = 1
      if (f.containsKey(ss)) {
        nv = 1 + f.getValue(ss)
      }
      f[ss] = nv
    }
    val m = f.values.maxOrNull()!!
    val l = f.keys.filter{i -> f[i] == m}.toList().sorted()
    return l[0]
  }

fun main() {

    if (mostfrequentletterpair("abcdbca") == "bc") {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (mostfrequentletterpair("cdeabeabfcdfabgcd") == "ab") {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
