import ch1.{array_median}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn array_median_test() {
  [
    #([2], [4]),
    #([1, 2, 3], [7, 8, 9, 10]),
    #([], [10, 20, 30, 40]),
    #([100], [1, 2, 3, 4, 5, 6, 7]),
    #([1, 2, 2], [2, 2, 3]),
  ]
  |> list.map(fn(e) {
    let #(left, right) = e
    array_median(left, right)
  })
  |> should.equal([3.0, 7.0, 25.0, 4.5, 2.0])
}
