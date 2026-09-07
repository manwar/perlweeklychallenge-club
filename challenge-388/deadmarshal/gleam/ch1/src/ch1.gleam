import gleam/list
import gleam/string

pub fn dyck_words(n: Int) -> List(String) {
  case n {
    0 -> [""]
    _ ->
      dyck_words_helper(n, 0, 0, [])
      |> list.sort(string.compare)
  }
}

fn dyck_words_helper(
  n: Int,
  open: Int,
  close: Int,
  acc: List(String),
) -> List(String) {
  case open == n && close == n {
    True -> [acc |> list.reverse |> string.join("")]
    False -> {
      let up = case open < n {
        True -> dyck_words_helper(n, open + 1, close, ["U", ..acc])
        False -> []
      }
      let down = case close < n && open > close {
        True -> dyck_words_helper(n, open, close + 1, ["D", ..acc])
        False -> []
      }
      list.append(up, down)
    }
  }
}
