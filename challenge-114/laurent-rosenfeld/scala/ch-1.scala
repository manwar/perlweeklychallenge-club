object palindrome extends App {
  var num = 1234
  var found = 0
  while (found == 0) {
    if (num.toString == num.toString.reverse) {
      println(num)
      found = 1
    }
    num += 1
  }
}
