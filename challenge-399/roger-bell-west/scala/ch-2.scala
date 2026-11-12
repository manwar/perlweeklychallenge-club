import scala.collection.mutable.ListBuffer

object Longestabsolutepath {
  def longestabsolutepath(fs: String): Int = {
    var components = new ListBuffer[Int]
    var maxlen = 0
    for (entry <- fs.split("\n")) {
      val parts = entry.split("\t")
      val depth = parts.size
      while (components.size < depth) {
        components += (0)
      }
      while (components.size >= depth) {
        components = components.dropRight(1)
      }
      components += (parts(parts.size - 1).size)
      if (parts(parts.size - 1) contains ".") {
        maxlen = List(maxlen, components.sum + components.size - 1).max
      }
    }
    maxlen
  }
  def main(args: Array[String]) {
    if (longestabsolutepath("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2") == 0) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestabsolutepath("file1.txt\nfile2.ext\na.png") == 9) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestabsolutepath("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png") == 38) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestabsolutepath("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt") == 14) {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (longestabsolutepath("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt") == 32) {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
