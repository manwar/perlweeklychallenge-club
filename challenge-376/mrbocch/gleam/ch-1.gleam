import gleam/int
import gleam/result
import gleam/string

type Color {
  Black
  White
}

fn get_color(pos: String) -> Color {
  let col = string.first(pos)
  assert result.is_ok(col) as "Can't empty have empty string position"

  let col = result.unwrap(col, "")

  let row = string.slice(pos, 1, 2)
  let row: Result(Int, Nil) = int.parse(row)
  assert result.is_ok(row) as "Invalid row"
  let row = result.unwrap(row, 0)
  assert row >= 1 && row <= 8 as "Invalid row"

  // is there really no way of doing this pretty? 
  case col {
    "a" | "c" | "e" | "g" ->
      case int.is_even(row) {
        True -> White
        False -> Black
      }
    _ ->
      case int.is_even(row) {
        True -> Black
        False -> White
      }
  }
}

fn same_color(pos1: String, pos2: String) -> Bool {
  get_color(pos1) == get_color(pos2)
}

pub fn main() -> Nil {
  assert same_color("a7", "f4") == True
  assert same_color("c1", "e8") == False
  assert same_color("b5", "h2") == False
  assert same_color("f3", "h1") == True
  assert same_color("a1", "c2") == False
  Nil
}
