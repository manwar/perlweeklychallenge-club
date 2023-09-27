import scala.collection.mutable

object Exactchange {
  class Reserve(vv: List[Int]) {
    var values: List[Int] = vv.sortWith(_ > _)
    var counts = Array.fill(values.length)(0)
    var vm = mutable.Map.empty[Int, Int]
    for ((v, i) <- values.zipWithIndex) {
      vm += (v -> i)
    }

    def makechange(price: Int, tendered: List[Int]): Boolean = {
      var vl = 0
      for (note <- tendered) {
        if (!vm.contains(note)) {
          return false
        }
        counts(vm(note)) += 1
        vl += note
      }
      if (vl < price) {
        return false
      }
      vl -= price
      for (bid <- 0 until values.length) {
        while (vl >= values(bid) && counts(bid) > 0) {
          vl -= values(bid)
          counts(bid) -= 1
        }
      }
      return (vl == 0)
    }
  }

  def exactchange(a: List[Int]): Boolean = {
    var reserve = new Reserve(List(5, 10, 20))
    for (tendered <- a) {
      if (!reserve.makechange(5, List(tendered))) {
        return false
      }
    }
    return true
  }

  def main(args: Array[String]) {
      if (exactchange(List(5, 5, 5, 10, 20))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (!exactchange(List(5, 5, 10, 10, 20))) {
          print("Pass")
      } else {
          print("Fail")
      }
      print(" ")
      if (exactchange(List(5, 5, 5, 20))) {
          print("Pass")
      } else {
          print("Fail")
      }
      println("")

  }
}
