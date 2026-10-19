import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  [
    [1, 3, 5, 4, 2, 6, 8],
    [1, 4, 4, 2, 1, 3, 5],
    [2, 10, 3, 1, 9],
    [1, 2, 3, 4, 3, 2, 1],
    [1, 3, 6, 4, 2, 7, 8, 4],
  ]
  |> list.map(ch2.trionic_list)
  |> should.equal([True, False, True, False, False])
}
