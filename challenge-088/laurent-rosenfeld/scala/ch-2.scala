import Array._
import scala.language.postfixOps
object spiralMatrix extends App {
  val mat = ofDim[Int](4, 6)
  var k = 1
  for (i <- 0 to mat.length - 1) {
    for (j <- 0 to mat(0).length - 1) {
      mat(i)(j) = k;
      k += 1
    }
  }
  println()
  printMatrix(mat)
  println(unrollMatrix(mat).mkString(" "))
  
  def printMatrix(mat: Array[Array[Int]]): Unit = {
    for (i <- 0 to mat.length - 1) {
      for (j <- 0 to mat(0).length - 1) {
        print(f"${mat(i)(j)}%3d");
      }
      println()
    }
    println(" ")
  }
  
  def unrollMatrix(matrix: Array[Array[Int]]): Array[Int] = {
    var mat = matrix
    var result = Array.empty[Int]
    var continue = true
    while (continue) {
      result = result ++ mat(0)
      mat = mat.drop(1)
      if (mat.isEmpty) {
        return result
      }
      for (i <- 0 to mat.length - 1) {
        result = result :+ mat(i).last
        mat(i) = mat(i).dropRight(1)
      }
      var i = mat.length - 1
      result = result ++ mat(mat.length - 1).reverse
      mat = mat.dropRight(1)
      i = mat.length - 1
      for (j <- (0 to i).reverse) {
        result = result :+ mat(j)(0)
        mat(j) = mat(j).drop(1)
      }
      if (mat.isEmpty) {
        return result
      }
    }
    return result
  }
}
 /*
   1  2  3  4  5  6
  7  8  9 10 11 12
 13 14 15 16 17 18
 19 20 21 22 23 24
 
1 2 3 4 5 6 12 18 24 23 22 21 20 19 13 7 8 9 10 11 17 16 15 14
*/