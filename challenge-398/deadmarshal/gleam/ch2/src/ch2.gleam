import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}
import gleam/string

pub fn string_difference(words: List(String)) -> Result(String, String) {
  let keyed = list.map(words, fn(w) { #(diffs(w), w) })
  let counts =
    list.fold(keyed, dict.new(), fn(m, pair) {
      dict.upsert(m, pair.0, fn(c) {
        case c {
          Some(n) -> n + 1
          None -> 1
        }
      })
    })
  find_unique(keyed, counts)
}

fn diffs(s: String) -> List(Int) {
  s
  |> string.to_utf_codepoints
  |> list.map(string.utf_codepoint_to_int)
  |> list.window_by_2
  |> list.map(fn(pair) { pair.1 - pair.0 })
}

fn find_unique(
  words: List(#(List(Int), String)),
  counts: Dict(List(Int), Int),
) -> Result(String, String) {
  case words {
    [] -> Error("")
    [#(k, w), ..rest] ->
      case dict.get(counts, k) {
        Ok(1) -> Ok(w)
        _ -> find_unique(rest, counts)
      }
  }
}
