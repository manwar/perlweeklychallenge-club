fun ballsandboxes(a: String): Int {
    var boxes = mutableMapOf<Int, MutableSet<Char>>()
    var colour = '@'
    a.toCharArray().forEachIndexed{i, c ->
        if (i % 2 == 0) {
            colour = c
        } else {
            val boxid = c.digitToInt()
            var s = mutableSetOf<Char>()
            if (boxes.contains(boxid)) {
                s = boxes.getValue(boxid)
            }
            s.add(colour)
            boxes[boxid] = s
        }
    }
    return boxes.values.filter{it.size >= 3}.size
}

fun main() {

    if (ballsandboxes("G0B1R2R0B0") == 1) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ballsandboxes("G1R3R6B3G6B1B6R1G3") == 3) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (ballsandboxes("B3B2G1B3") == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
