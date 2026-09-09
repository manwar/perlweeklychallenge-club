import gleam/int
import gleam/list
import gleam/order.{Lt}
import gleam/string

pub fn order_characters(s: String, k: Int) -> String {
  case s, k {
    "", _ -> ""
    _, 1 -> smallest_rotation(s)
    _, _ -> sort_string(s)
  }
}

fn smallest_rotation(s: String) -> String {
  let n = string.length(s)
  let doubled = s <> s
  int.range(0, n, [], list.prepend)
  |> list.fold(string.slice(doubled, 0, n), fn(acc, i) {
    let cand = string.slice(doubled, i, n)
    case string.compare(cand, acc) {
      Lt -> cand
      _ -> acc
    }
  })
}

fn sort_string(s: String) -> String {
  s |> string.to_graphemes |> list.sort(string.compare) |> string.concat
}
