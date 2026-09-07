import gleam/int
import gleam/list

pub fn zig_zag_subarray(xs: List(Int)) -> Int {
  case xs {
    [] -> 0
    [_] -> 1
    [h, ..rest] -> {
      let #(_, _, _, max) =
        list.fold(rest, #(h, 1, 1, 1), fn(acc, x) {
          let #(prev, up, down, max) = acc
          case x {
            _ if x > prev -> #(x, down + 1, 1, int.max(max, down + 1))
            _ if x < prev -> #(x, 1, up + 1, int.max(max, up + 1))
            _ -> #(x, 1, 1, max)
          }
        })
      max
    }
  }
}
