import ch2.{order_characters}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  [
    #("dbca", 1),
    #("geeks", 2),
    #("cbaed", 3),
    #("fedcba", 4),
    #("perl", 1),
    #("oloolooo", 1),
    #("oloooolo", 1),
  ]
  |> list.map(fn(t) {
    let #(s, i) = t
    order_characters(s, i)
  })
  |> should.equal([
    "adbc",
    "eegks",
    "abcde",
    "abcdef",
    "erlp",
    "looloooo",
    "looloooo",
  ])
}
