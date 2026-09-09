import ch1.{decode_string}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn decode_string_test() {
  [
    "2[3[a]]",
    "10[a]",
    "a2[b]c3[d]e",
    "2[a2[b]c]",
    "1[a]2[b3[c]]",
  ]
  |> list.map(decode_string)
  |> should.equal([
    Ok("aaaaaa"),
    Ok("aaaaaaaaaa"),
    Ok("abbcddde"),
    Ok("abbcabbc"),
    Ok("abcccbccc"),
  ])
}
