object root extends App {
  val n = Array.range(10, 101, 10) // (10, 20, ... 100)
  val mvg_avg = new Array[Int](10)
  mvg_avg(0) = n(0)
  for (i <- 1 to 9) {
    mvg_avg(i) = (mvg_avg(i - 1) * i + n(i)) / (i + 1)
  }
  println(mvg_avg.mkString(" "))
}
