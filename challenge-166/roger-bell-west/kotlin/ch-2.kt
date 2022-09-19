import kotlin.io.*
import kotlin.math.max

fun kdd(dirlist0: ArrayList<String>): ArrayList<ArrayList<String>> {
    val dirlist = ArrayList(dirlist0.sorted())
    var fx = mutableMapOf<String,MutableSet<String>>()
    for (d in dirlist) {
        java.io.File(d).listFiles().forEach() { entry ->
                                                    var nn = entry.getName()
                                                if (entry.isDirectory()) {
                                                    nn += "/"
                                                }
                                                if (!fx.containsKey(nn)) {
                                                    fx[nn] = mutableSetOf<String>()
                                                }
                                                fx[nn]!!.add(d)
        }
    }
    val mm = dirlist.size
    var out = arrayListOf(dirlist)
    for (f in fx.keys.sorted()) {
        if (fx[f]!!.size != mm) {
            var l = arrayListOf<String>()
            for (d in dirlist) {
                if (fx[f]!!.contains(d)) {
                    l.add(f)
                } else {
                    l.add("")
                }
            }
            out.add(l)
        }
    }
    return(out)
}

fun tabular(d: ArrayList<ArrayList<String>>) {
    var columnlength = ArrayList<Int>()
    for (row in d) {
        row.forEachIndexed {i,col ->
                                while (columnlength.size <= i) {
                                    columnlength.add(0)
                                }
                            columnlength[i] = max(columnlength[i],col.length)
        }
    }
    val fstr=columnlength.map {l -> "%-" + l.toString() + "s"}.joinToString(" | ")
    for (row in d) {
        println(fstr.format(*row.toTypedArray()))
    }
}

fun main() {
    tabular(kdd(arrayListOf<String>("dir_a","dir_b","dir_c")))
}
