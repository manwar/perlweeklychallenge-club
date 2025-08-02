class Op(
    var a: List<Int>,
    var cost: Int
) {}

fun equalizearray(a0: List<Int>, x: Int, y: Int): Int {
    val a = a0.sorted()
    val limit = a.last()
    val queue = ArrayDeque<Op>()
    queue.add(Op(a, 0))
    var mc = -1
    while (queue.size > 0) {
        val op = queue.removeFirst()
        if (mc == -1 || mc > op.cost) {
            if (op.a[0] == op.a.last()) {
                mc = op.cost
            } else {
                var p = ArrayList(op.a)
                p[0] += 1
                if (p[0] <= limit) {
                    p.sort()
                    queue.add(Op(p.toList(), op.cost + x))
                    var q = ArrayList(op.a)
                    q[0] += 1
                    q[1] += 1
                    if (q[1] <= limit) {
                        q.sort()
                        queue.add(Op(q.toList(), op.cost + y))
                    }
                }
            }
        }
    }
    return mc
}

fun main() {

    if (equalizearray(listOf(4, 1), 3, 2) == 9) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (equalizearray(listOf(2, 3, 3, 3, 5), 2, 1) == 6) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
