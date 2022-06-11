fun fds(n: Int): ArrayList<Int> {
    var o=ArrayList<Int>()
    var f=arrayOf(1,0)
    var ft=mutableSetOf<Int>()
    for (i in f) {
        ft.add(i)
    }
    var k=0
    while (o.size < n) {
        var j: Int=k
        var ds=0
        while (j > 0) {
            ds += j % 10
            j = j/10
        }
        while (f[0] < ds) {
            val t=f[1]+f[0]
            f[1]=f[0]
            f[0]=t
            ft.add(f[0])
        }
        if (ft.contains(ds)) {
            o.add(k)
        }
        k += 1
    }
    return o
}

fun main() {
  if (fds(8) == listOf(0, 1, 2, 3, 5, 8, 10, 11)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")

  if (fds(20) == listOf(0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")

  if (fds(61) == listOf(0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44, 49, 50, 53, 58, 62, 67, 71, 76, 80, 85, 94, 100, 101, 102, 104, 107, 110, 111, 113, 116, 120, 122, 125, 131, 134, 139, 140, 143, 148, 152, 157, 161, 166, 170, 175, 184, 193, 200, 201, 203, 206)) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
