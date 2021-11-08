object nextbin extends App {

  def number_of_1(in: Int): Int = {
    val binlist = in.toBinaryString.toList
    var count = 0
    for (char <- binlist) {
      if (char == '1') count += 1
    }
    return count
  }
  var num = 111
  val target = number_of_1(num)
  var found = 0
  while (found == 0) {
    num += 1
    if (number_of_1(num) == target) {
      println(num)
      found = 1
    }
  }
}
