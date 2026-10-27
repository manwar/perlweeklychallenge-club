import gleam/int
import gleam/list
import gleam/set

pub fn absent_smallest_positive(xs: List(Int)) -> Int {
  let s = set.from_list(xs)
  let n = list.length(xs)
  let start = int.max(1, int.sum(xs) / n + 1)
  list.fold(int.range(1, n + 1, [], list.prepend), start, fn(acc, _) {
    case set.contains(s, acc) {
      True -> acc + 1
      False -> acc
    }
  })
}
