import ch1
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn equal_list_test() {
  should.equal(
    [
      ch1.equal_list(["a", "bc"], ["ab", "c"]),
      ch1.equal_list(["a", "b", "c"], ["a", "bc"]),
      ch1.equal_list(["a", "bc"], ["a", "c", "b"]),
      ch1.equal_list(["ab", "c", ""], ["", "a", "bc"]),
      ch1.equal_list(["p", "e", "r", "l"], ["perl"]),
    ],
    [True, True, False, True, True],
  )
}
