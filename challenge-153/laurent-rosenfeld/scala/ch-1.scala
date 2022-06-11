object fact_left extends App {
  var fact = 1
  var left_fact = 1
  for (n <- 1 to 10) {
    println(left_fact)
      fact *= n
    left_fact += fact
  }
}
