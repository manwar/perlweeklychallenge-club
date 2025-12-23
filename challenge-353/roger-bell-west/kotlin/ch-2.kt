fun validatecoupon(codes: List<String>, names: List<String>, status: List<Boolean>): List<Boolean> {
    val rx = "^([0-9A-Za-z_]+)$".toRegex()
    val dep = listOf("electronics", "grocery", "pharmacy", "restaurant").toSet()
    var out = ArrayList<Boolean>()
    for (i in 0 .. codes.size - 1) {
        out.add(rx.containsMatchIn(codes[i]) && dep.contains(names[i]) && status[i])
    }
    return out.toList()
}

fun main() {

    if (validatecoupon(listOf("A123", "B_456", "C789", "D@1", "E123"), listOf("electronics", "restaurant", "electronics", "pharmacy", "grocery"), listOf(true, false, true, true, true)) == listOf(true, false, true, false, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validatecoupon(listOf("Z_9", "AB_12", "G01", "X99", "test"), listOf("pharmacy", "electronics", "grocery", "electronics", "unknown"), listOf(true, true, false, true, true)) == listOf(true, true, false, true, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validatecoupon(listOf("_123", "123", "", "Coupon_A", "Alpha"), listOf("restaurant", "electronics", "electronics", "pharmacy", "grocery"), listOf(true, true, false, true, true)) == listOf(true, true, false, true, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validatecoupon(listOf("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"), listOf("electronics", "electronics", "grocery", "grocery"), listOf(true, true, true, true)) == listOf(true, true, true, true)) {
        print("Pass")
    } else {
        print("Fail")
    }
    print(" ")
    if (validatecoupon(listOf("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"), listOf("restaurant", "electronics", "grocery", "pharmacy", "electronics"), listOf(true, true, true, true, false)) == listOf(true, true, true, true, false)) {
        print("Pass")
    } else {
        print("Fail")
    }
    println("")

}
