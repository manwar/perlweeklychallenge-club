fun common_substring(a0: List<String>): List<String> {
    var a = ArrayList(a0)
    a.sortWith(compareBy { it.length })
    var results = ArrayList<String>()
    for (l in (1 .. a[0].length - 1).reversed()) {
        for (offset in 0 .. a[0].length - l) {
            var m = true
            val sample = a[0].substring(offset, l + offset)
            for (axi in 1 .. a.size - 1) {
                if (a[axi].indexOf(sample) == -1) {
                    m = false
                    break
                }
            }
            if (m) {
                results.add(sample);
            }
        }
        // if we wanted longest common substring we'd exit here
        // on non-empty results
    }
    return results.toList()
}

fun is_avc(a: String): Boolean {
    var valid = true
    var laststate = false
    a.toList().forEachIndexed {i, c ->
                                   var thisstate = false
                               if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
                                   thisstate = true
                               }
                               if (i > 0 && thisstate == laststate) {
                                   valid = false
                               }
                               laststate = thisstate
    }
    return valid
}
  
fun alternatingvowelsconsonants(a: List<String>): List<String> {
    val c2 = common_substring(a).filter{is_avc(it)}
    if (c2.size > 0) {
        val l = c2[0].length
        return c2.filter{it.length == l}
    } else {
        return emptyList<String>()
    }
}

fun main() {

    if (alternatingvowelsconsonants(listOf("relocate", "delocate", "allocate")) == listOf("locate")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(listOf("apple", "banana", "cherry")) == emptyList<String>()) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(listOf("navigate", "cavity", "gravity")) == listOf("avi")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(listOf("pedalgia", "pedalboard", "pedantic")) == listOf("peda")) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (alternatingvowelsconsonants(listOf("schoolmaster", "schoolhouse", "schooling")) == listOf("ho", "ol")) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
