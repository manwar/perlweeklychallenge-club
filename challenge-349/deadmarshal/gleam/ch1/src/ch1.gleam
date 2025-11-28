import gleam/dict
import gleam/int
import gleam/list
import gleam/string

pub fn power_string(s: String) -> Int {
  case s {
    "" -> 0
    _ -> {
      let assert Ok(len) =
        s
        |> string.to_graphemes
        |> list.group(fn(i) { i })
        |> dict.values
        |> list.map(list.length)
        |> list.max(int.compare)
      len
    }
  }
}

pub fn main() -> Nil {
  Nil
}
