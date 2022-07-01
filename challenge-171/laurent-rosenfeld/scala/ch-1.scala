object abundant extends App {
  def is_abundant(n: Int): Boolean = {
    var sum = 0
    for (i <- 1 to n/2) {
      if (n % i == 0) {
        sum += i
        if (sum > n) {
          return true
        }
      }
    }
    return false;
  }
  var count = 0
  var j = 1
  while (count < 20) {
    if (is_abundant(j)) {
      print(s"$j ")
      count += 1
    }
    j += 2
  }
}
