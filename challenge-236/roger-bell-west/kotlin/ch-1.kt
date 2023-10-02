class Reserve(vls: List<Int>)  {
    var vll: ArrayList<Int> = ArrayList(0)
    var counts: ArrayList<Int> = ArrayList(0)
    var vm = mutableMapOf<Int, Int>()

    init {
        var vq = ArrayList(vls)
        vq.sort()
        vq.reverse()
        vll = vq
        for (i in 1..vq.size) {
            counts.add(0)
        }
        vq.forEachIndexed {i, v -> vm.put(v, i)}
    }

    fun makechange(price: Int, tendered: List<Int>): Boolean {
        var vl = 0
        for (note in tendered) {
            if (!vm.contains(note)) {
                return false
            }
            counts[vm.getValue(note)] += 1
            vl += note
        }
        if (vl < price) {
            return false
        }
        vl -= price
        for (bid in 0..vll.size-1) {
            while (vl >= vll[bid] && counts[bid] > 0) {
                vl -= vll[bid]
                counts[bid] -= 1
            }
        }
        return (vl == 0)
    }
}

fun exactchange(a: List<Int>): Boolean {
    var reserve = Reserve(listOf(5, 10, 20))
    for (tendered in a) {
        if (!reserve.makechange(5, listOf(tendered))) {
            return false
        }
    }
    return true
}


fun main() {

    if (exactchange(listOf(5, 5, 5, 10, 20))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!exactchange(listOf(5, 5, 10, 10, 20))) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (exactchange(listOf(5, 5, 5, 20))) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
