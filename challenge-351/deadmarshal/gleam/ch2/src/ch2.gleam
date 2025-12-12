import gleam/float
import gleam/list

pub fn arithmetic_progression(l: List(Float)) -> Bool {
  let sorted = list.sort(l, float.compare)
  case sorted {
    [] | [_] -> True
    [first, second, ..rest] -> {
      let d = second -. first
      arithmetic_progression_helper(rest, second, d)
    }
  }
}

fn arithmetic_progression_helper(l: List(Float), last: Float, d: Float) -> Bool {
  case l, last, d {
    [], _, _ -> True
    [current, ..rest], last, d ->
      case current -. last == d {
        True -> arithmetic_progression_helper(rest, current, d)
        False -> False
      }
  }
}

pub fn main() -> Nil {
  Nil
}
