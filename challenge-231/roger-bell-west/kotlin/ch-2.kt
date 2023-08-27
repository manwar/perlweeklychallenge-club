fun seniorcitizens(a: List<String>): Int {
    var p = 0
    for (st in a) {
        if (st.toCharArray()[11] >= '6') {
            p += 1
        }
    }
    return p
}

fun main() {

    if (seniorcitizens(listOf("7868190130M7522", "5303914400F9211", "9273338290F4010")) == 2) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (seniorcitizens(listOf("1313579440F2036", "2921522980M5644")) == 0) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
