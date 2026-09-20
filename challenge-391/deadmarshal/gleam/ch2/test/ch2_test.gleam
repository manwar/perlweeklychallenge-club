import ch2.{Box, arrange_box}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn arrange_box_test() {
  [
    [Box(1, 3), Box(3, 5), Box(6, 8), Box(2, 4)],
    [Box(4, 5), Box(4, 6), Box(6, 7), Box(2, 3), Box(4, 3)],
    [Box(5, 5), Box(5, 5), Box(5, 5)],
    [Box(2, 100), Box(3, 200), Box(4, 300), Box(5, 50), Box(5, 400)],
    [Box(10, 20), Box(15, 10), Box(20, 30), Box(12, 18), Box(16, 25)],
  ]
  |> list.map(arrange_box)
  |> should.equal([4, 3, 1, 4, 3])
}
