import ch2
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn sum_of_words_test() {
  should.equal(
    [
      ch2.sum_of_words("acb", "cba", "cdb"),
      ch2.sum_of_words("aab", "aac", "ad"),
      ch2.sum_of_words("bc", "je", "jg"),
      ch2.sum_of_words("a", "aaaa", "aa"),
      ch2.sum_of_words("c", "d", "h"),
      ch2.sum_of_words("gfi", "hbf", "bdhd"),
    ],
    [
      True,
      True,
      False,
      True,
      False,
      True,
    ],
  )
}
