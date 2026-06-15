import gleam/int
import gleam/list
import gleam/string

pub fn second_largest_digit(s: String) -> Int {
  let digits =
    s
    |> string.to_graphemes
    |> list.filter_map(fn(c) {
      case int.parse(c) {
        Ok(n) if n >= 0 && n <= 9 -> Ok(n)
        _ -> Error(-1)
      }
    })

  let sorted_uniq =
    digits |> list.sort(int.compare) |> list.reverse |> list.unique

  case sorted_uniq {
    [_, second, ..] -> second
    _ -> -1
  }
}

pub fn main() -> Nil {
  Nil
}
