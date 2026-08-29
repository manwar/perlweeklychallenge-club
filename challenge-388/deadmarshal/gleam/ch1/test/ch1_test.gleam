import ch1
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn dyck_words_test() {
  should.equal(ch1.dyck_words(1), ["UD"])
  should.equal(ch1.dyck_words(2), ["UDUD", "UUDD"])
  should.equal(ch1.dyck_words(3), [
    "UDUDUD",
    "UDUUDD",
    "UUDDUD",
    "UUDUDD",
    "UUUDDD",
  ])
  should.equal(ch1.dyck_words(0), [""])
  should.equal(ch1.dyck_words(4), [
    "UDUDUDUD",
    "UDUDUUDD",
    "UDUUDDUD",
    "UDUUDUDD",
    "UDUUUDDD",
    "UUDDUDUD",
    "UUDDUUDD",
    "UUDUDDUD",
    "UUDUDUDD",
    "UUDUUDDD",
    "UUUDDDUD",
    "UUUDDUDD",
    "UUUDUDDD",
    "UUUUDDDD",
  ])
}
