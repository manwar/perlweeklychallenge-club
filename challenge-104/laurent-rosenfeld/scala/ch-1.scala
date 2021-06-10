object Fusc extends App {
  import scala.collection.mutable.ArrayBuffer
  var fusc = ArrayBuffer[Int](0, 1)
  for (i <- 2 until 50)
    fusc += (if (i % 2 == 0) fusc(i / 2)
      else fusc((i - 1) / 2) + fusc((i + 1) / 2))

  println(fusc.mkString(" "))
}
