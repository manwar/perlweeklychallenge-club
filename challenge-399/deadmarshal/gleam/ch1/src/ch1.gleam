import gleam/dict.{type Dict}
import gleam/int
import gleam/result
import gleam/string

pub fn longest_repeating_character(s: String, k: Int) -> Int {
  let chars = string.to_graphemes(s)
  helper(chars, chars, 0, 0, 0, dict.new(), k)
}

fn helper(
  rest: List(String),
  left_chars: List(String),
  left: Int,
  right: Int,
  max_count: Int,
  counts: Dict(String, Int),
  k: Int,
) -> Int {
  case rest {
    [] -> right - left
    [c, ..rest] -> {
      let cnt = count(counts, c) + 1
      let counts = dict.insert(counts, c, cnt)
      let max_count = int.max(max_count, cnt)

      case right - left + 1 - max_count > k {
        True ->
          case left_chars {
            [lc, ..left_rest] -> {
              let counts = dict.insert(counts, lc, count(counts, lc) - 1)
              helper(rest, left_rest, left + 1, right + 1, max_count, counts, k)
            }
            [] -> helper(rest, [], left, right + 1, max_count, counts, k)
          }
        False -> helper(rest, left_chars, left, right + 1, max_count, counts, k)
      }
    }
  }
}

fn count(counts: Dict(String, Int), char: String) -> Int {
  dict.get(counts, char) |> result.unwrap(0)
}
