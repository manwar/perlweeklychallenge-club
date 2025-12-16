import gleam/list
import gleam/string

pub fn match_string(l: List(String)) -> List(String) {
  match_string_helper(l, l, [])
}

fn match_string_helper(
  l: List(String),
  strs: List(String),
  acc: List(String),
) -> List(String) {
  case l, strs, acc {
    [], _, acc -> acc |> list.reverse
    [a, ..rest], strs, acc ->
      case is_contained_in_others(a, strs) && !list.contains(acc, a) {
        True -> match_string_helper(rest, strs, [a, ..acc])
        False -> match_string_helper(rest, strs, acc)
      }
  }
}

fn is_contained_in_others(a: String, strs: List(String)) -> Bool {
  list.any(strs, fn(b) { string.contains(b, a) && b != a })
}

pub fn main() -> Nil {
  Nil
}
