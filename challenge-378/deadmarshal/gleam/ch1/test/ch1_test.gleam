import ch1
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn second_largest_digit_test() {
  should.equal(
    [
      ch1.second_largest_digit("aaaaa77777"),
      ch1.second_largest_digit("abcde"),
      ch1.second_largest_digit("9zero8eight7seven9"),
      ch1.second_largest_digit("xyz9876543210"),
      ch1.second_largest_digit("4abc4def2ghi8jkl2"),
    ],
    [-1, -1, 8, 8, 4],
  )
}
