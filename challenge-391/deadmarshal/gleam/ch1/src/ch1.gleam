import gleam/int
import gleam/list

pub fn array_median(l1: List(Int), l2: List(Int)) -> Float {
  let combined = list.append(l1, l2)
  let resorted = list.sort(combined, int.compare)
  let len = list.length(resorted)
  case len {
    0 -> 0.0
    _ ->
      case len % 2 {
        1 -> {
          let mid = len / 2
          let assert Ok(value) = at(resorted, mid)
          int.to_float(value)
        }
        _ -> {
          let left_middle = len / 2 - 1
          let assert Ok(left) = at(resorted, left_middle)
          let assert Ok(right) = at(resorted, left_middle + 1)
          int.to_float(left + right) /. 2.0
        }
      }
  }
}

fn at(l: List(a), i: Int) -> Result(a, Nil) {
  case l, i {
    [], _ -> Error(Nil)
    [first, ..], 0 -> Ok(first)
    [_, ..rest], n if n > 0 -> at(rest, n - 1)
    _, _ -> Error(Nil)
  }
}
