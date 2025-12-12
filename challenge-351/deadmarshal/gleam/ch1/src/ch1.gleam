import gleam/int
import gleam/list

fn slice(l: List(a), start: Int, length: Int) -> List(a) {
  l |> list.drop(start) |> list.take(length)
}

pub fn special_average(l: List(Int)) -> Int {
  case l {
    [] | [_] -> 0
    _ -> {
      let sorted = list.sort(l, int.compare)
      let sub = slice(sorted, 1, list.length(sorted) - 2)
      list.fold(sub, 0, fn(acc, e) { acc + e }) / list.length(sub)
    }
  }
}

pub fn main() -> Nil {
  Nil
}
