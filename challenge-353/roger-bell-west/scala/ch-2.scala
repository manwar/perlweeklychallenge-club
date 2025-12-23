import scala.util.matching.Regex
import scala.collection.mutable.ListBuffer

object Validatecoupon {
  def validatecoupon(codes: List[String], names: List[String], status: List[Boolean]): List[Boolean] = {
    val rx = "^([0-9A-Za-z_]+)$".r
    val dep = List("electronics", "grocery", "pharmacy", "restaurant").toSet
    var out = new ListBuffer[Boolean]
    for (i <- 0 until codes.size) {
      out +=
      status(i) && dep.contains(names(i)) && (codes(i) match {
        case rx(_n) => true
        case _ => false
      })
    }
    out.toList
  }

  def main(args: Array[String]) {
    if (validatecoupon(List("A123", "B_456", "C789", "D@1", "E123"), List("electronics", "restaurant", "electronics", "pharmacy", "grocery"), List(true, false, true, true, true)) == List(true, false, true, false, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validatecoupon(List("Z_9", "AB_12", "G01", "X99", "test"), List("pharmacy", "electronics", "grocery", "electronics", "unknown"), List(true, true, false, true, true)) == List(true, true, false, true, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validatecoupon(List("_123", "123", "", "Coupon_A", "Alpha"), List("restaurant", "electronics", "electronics", "pharmacy", "grocery"), List(true, true, false, true, true)) == List(true, true, false, true, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validatecoupon(List("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"), List("electronics", "electronics", "grocery", "grocery"), List(true, true, true, true)) == List(true, true, true, true)) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (validatecoupon(List("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"), List("restaurant", "electronics", "grocery", "pharmacy", "electronics"), List(true, true, true, true, false)) == List(true, true, true, true, false)) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
