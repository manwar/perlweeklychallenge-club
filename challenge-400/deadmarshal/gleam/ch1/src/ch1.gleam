import gleam/int
import gleam/list
import gleam/string

fn has_unique_digits(x: Int) -> Bool {
  let digits = x |> int.to_string |> string.to_graphemes
  list.length(digits) == list.length(list.unique(digits))
}

pub fn largest_interval(n: Int) -> Int {
  case n < 1 {
    True -> 0
    False ->
      case
        int.range(1, n + 1, [], list.prepend)
        |> list.reverse
        |> list.filter(has_unique_digits)
      {
        [] -> 0
        [first, ..rest] -> {
          let #(_last, jump) =
            list.fold(rest, #(first, 0), fn(acc, x) {
              let #(prev, best) = acc
              #(x, int.max(best, x - prev))
            })
          jump
        }
      }
  }
}
