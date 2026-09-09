import gleam/int
import gleam/result
import gleam/string

pub fn decode_string(s: String) -> Result(String, Nil) {
  case s {
    "" -> Ok("")
    _ -> helper(s, [], [], 0, "")
  }
}

fn helper(
  s: String,
  s1: List(Int),
  s2: List(String),
  num: Int,
  res: String,
) -> Result(String, Nil) {
  case string.pop_grapheme(s) {
    Error(Nil) -> Ok(res)
    Ok(#(h, t)) ->
      case h {
        "[" -> helper(t, [num, ..s1], [res, ..s2], 0, "")
        "]" ->
          case s1, s2 {
            [popped1, ..s1t], [popped2, ..s2t] -> {
              let temp = string.repeat(res, popped1)
              helper(t, s1t, s2t, num, popped2 <> temp)
            }
            _, _ -> Ok(res)
          }
        "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" -> {
          use d <- result.try(int.parse(h))
          helper(t, s1, s2, num * 10 + d, res)
        }
        _ -> helper(t, s1, s2, num, res <> h)
      }
  }
}
