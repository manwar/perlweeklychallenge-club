import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn example_test() {
  ["ULD", "ULDR", "UUURRRDDD", "UURRRDDLLL", "RRUULLDDRRUU"]
  |> list.map(ch2.meeting_point)
  |> should.equal([False, True, False, True, False])
}
