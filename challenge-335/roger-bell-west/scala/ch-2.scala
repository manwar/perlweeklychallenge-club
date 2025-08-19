import scala.collection.mutable
import scala.collection.mutable.ListBuffer

object Findwinner {
  def findwinner(a: List[List[Int]]): String = {
    var outcome = "Null"
    var board = List(List(0, 0, 0).to[ListBuffer],
      List(0, 0, 0).to[ListBuffer],
      List(0, 0, 0).to[ListBuffer]
    ).to[ListBuffer]
    var player = 1
    for (play <- a) {
      board(play(0))(play(1)) = player
      player = 3 - player
    }
    for (pattern <- List(
      List(0, 0, 1, 0),
      List(0, 1, 1, 0),
      List(0, 2, 1, 0),
      List(0, 0, 0, 1),
      List(1, 0, 0, 1),
      List(2, 0, 0, 1),
      List(0, 0, 1, 1),
      List(0, 2, 1, -1)
    )) {
      if (outcome == "Null") {
        var cellvals = mutable.Set.empty[Int]
        for (i <- 0 to 2) {
          val x = pattern(0) + i * pattern(2)
          val y = pattern(1) + i * pattern(3)
          cellvals += board(y)(x)
        }
        if (cellvals.size == 1) {
          var winner = cellvals.toList(0)
          if (winner == 1) {
            outcome = "A"
          } else if (winner == 2) {
            outcome = "B"
          }
        }
      }
    }
    if (outcome == "Null") {
      if (a.size == 9) {
        outcome = "Draw"
      } else {
        outcome = "Pending"
      }
    }
    outcome
  }

  def main(args: Array[String]) {
    if (findwinner(List(List(0, 0), List(2, 0), List(1, 1), List(2, 1), List(2, 2))) == "A") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwinner(List(List(0, 0), List(1, 1), List(0, 1), List(0, 2), List(1, 0), List(2, 0))) == "B") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwinner(List(List(0, 0), List(1, 1), List(2, 0), List(1, 0), List(1, 2), List(2, 1), List(0, 1), List(0, 2), List(2, 2))) == "Draw") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwinner(List(List(0, 0), List(1, 1))) == "Pending") {
      print("Pass")
    } else {
      print("Fail")
    }
    print(" ")
    if (findwinner(List(List(1, 1), List(0, 0), List(2, 2), List(0, 1), List(1, 0), List(0, 2))) == "B") {
      print("Pass")
    } else {
      print("Fail")
    }
    println("")

  }
}
