fun str2tree(st: String): ArrayList<Int> {
    var o=ArrayList<Int>()
    o.add(0)
    var d=0
    var p=0
    for (e in st.split(" ")) {
        if (e == "|") {
            d += 1
            p = 0
            val m = (1 shl (d+1)) -1
            while (o.size < m) {
                o.add(0)
            }
        } else {
            var y=0
            if (e != "*") {
                y = e.toInt()
            }
            val i=(1 shl d) -1 +p
            o[i] = y
            p += 1
        }
    }
    return o
}

fun mindepth(tree: ArrayList<Int>): Int {
    var firstleaf=tree.size
    for ((i, e) in tree.withIndex()) {
        if (e == 0) {
            continue
        } else if ((i+1) shl 1 >= tree.size) {
            firstleaf = i
            break
        } else {
            val ni=((i+1) shl 1)-1
            if (tree[ni]==0 && tree[ni+1] == 0) {
                firstleaf = i
                break
            }
        }
    }
    firstleaf += 1
    var d=0
    while (firstleaf > 0) {
        firstleaf = firstleaf shr 1
        d += 1
    }
    return d
}

fun main() {
  if (mindepth(str2tree("1 | 2 3 | 4 5")) == 2) {
    print("Pass")
  } else {
    print("FAIL")
  }
  print(" ")
  if (mindepth(str2tree("1 | 2 3 | 4 * * 5 | * 6")) == 3) {
    print("Pass")
  } else {
    print("FAIL")
  }
  println("")
}
