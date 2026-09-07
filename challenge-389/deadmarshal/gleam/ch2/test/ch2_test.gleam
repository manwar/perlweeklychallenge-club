import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn zig_zag_subarray_test() {
  [
    [9, 4, 2, 10, 7, 8, 8, 1, 9],
    [1, 7, 4, 9, 2, 5],
    [1, 2, 3, 4, 5],
    [4, 4, 4],
    [10, 20, 15, 12, 18],
  ]
  |> list.map(ch2.zig_zag_subarray)
  |> should.equal([5, 6, 2, 1, 3])
}
