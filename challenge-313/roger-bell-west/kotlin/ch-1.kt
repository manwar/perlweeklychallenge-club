fun brokenkeys(name: String, typed: String): Boolean {
    val nt = name.toList()
    val tt = typed.toList()
    var ni = 0
    var ti = 0
    while (true) {
        if (nt[ni] != tt[ti]) {
            return false
        }
        if (ti == tt.size - 1) {
            break
        } else {
            if (ni < nt.size - 1 && nt[ni + 1] == nt[ni]) {
                ni += 1
            } else {
                while (ti < tt.size && tt[ti] == nt[ni]) {
                    ti += 1
                }
                if (ti == tt.size) {
                    break
                }
                ni += 1
            }
        }
    }
    return true
}

fun main() {

    if (brokenkeys("perl", "perrrl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeys("raku", "rrakuuuu")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (!brokenkeys("python", "perl")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (brokenkeys("coffeescript", "cofffeescccript")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
