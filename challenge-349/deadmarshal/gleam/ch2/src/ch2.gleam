import gleam/list
import gleam/string

pub fn meeting_point(s: String) -> Bool {
  let #(x, y) =
    s
    |> string.to_graphemes
    |> list.fold(#(0, 0), fn(acc, c) {
      let #(x, y) = acc
      case c {
        "U" -> #(x, y + 1)
        "R" -> #(x + 1, y)
        "D" -> #(x, y - 1)
        "L" -> #(x - 1, y)
        _ -> #(x, y)
      }
    })
  x == 0 && y == 0
}

pub fn main() -> Nil {
  Nil
}
