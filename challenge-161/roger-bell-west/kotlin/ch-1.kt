fun main() {
    var b = ArrayList<String>()
    while(true) {
        var line = readLine()
        if (line == null) {
            break
        }
        var u = true
        for (ai in line.toCharArray().toList().windowed(size = 2)) {
            if (ai[0] > ai[1]) {
                u = false
                break
            }
        }
        if (u) {
            b.add(line)
        }
    }
    b.sortWith(compareByDescending { it.length })
    for (l in b) {
        println(l)
    }
}
