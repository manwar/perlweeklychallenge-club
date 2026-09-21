import gleam/string

pub fn convert_palindrome(s: String) -> String {
  let r = string.reverse(s)
  find(s, r, 0)
}

fn find(s: String, r: String, i: Int) -> String {
  case string.drop_end(s, i) == string.drop_start(r, i) {
    True -> string.slice(r, 0, i) <> s
    False -> find(s, r, i + 1)
  }
}
