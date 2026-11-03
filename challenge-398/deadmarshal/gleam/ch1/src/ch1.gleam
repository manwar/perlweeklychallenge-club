import gleam/int
import gleam/list

pub fn divisible_average(xs: List(Int)) -> Int {
  let f = list.filter(xs, fn(e) { e % 2 == 0 && e % 3 == 0 })
  let n = list.length(f)
  case n {
    0 -> 0
    _ -> int.sum(f) / n
  }
}
