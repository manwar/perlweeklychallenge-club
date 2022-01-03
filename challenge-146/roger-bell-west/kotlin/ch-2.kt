class Fraction(var n: Int = 1,var d: Int = 1) {

    fun get_parent(): Fraction {
        var nn=n
        var dd=d
        if (nn < dd) {
            dd -= nn
        } else {
            nn -= dd
        }
        return Fraction(nn,dd)
    }

    fun stringify(): String {
        return "%d/%d".format(n,d)
    }

    fun set_from_string(s: String): Fraction {
        val q=s.split("/")
        n=q[0].toInt()
        d=q[1].toInt()
        return this
    }
}

fun p_gp(s: String): ArrayList<String> {
    var f=Fraction().set_from_string(s)
    var out=ArrayList<String>()
    for (i in 1..2) {
        f=f.get_parent()
        out.add(f.stringify())
    }
    return out
}

fun main() {
    if(p_gp("3/5") == listOf("3/2","1/2")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    print(" ")

    if(p_gp("4/3") == listOf("1/3","1/2")) {
        print("Pass")
    } else {
        print("FAIL")
    }
    println("")

}
