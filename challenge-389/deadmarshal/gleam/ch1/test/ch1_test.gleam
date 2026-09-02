import ch1.{Melody}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn reorder_notes_test() {
  [
    Melody("Bach", ["C", "D", "E", "F#", "G", "A", "B"], [7, 1, 6, 2, 5, 3, 4]),
    Melody("Beethoven", ["C", "D", "F#", "G", "Ab"], [1, 3, 5, 2, 4]),
    Melody("Brahms", ["C", "Db", "Eb", "F", "G", "Ab", "Bb", "C", "D"], [
      9,
      3,
      7,
      1,
      8,
      5,
      2,
      6,
      4,
    ]),
    Melody("Bruckner", ["G", "F#", "Bb", "C", "D", "Eb", "F"], [
      4,
      7,
      2,
      6,
      1,
      5,
      3,
    ]),
    Melody("Berg", ["C#"], [1]),
  ]
  |> list.map(ch1.reorder_notes)
  |> should.equal([
    "BACH => D F# A B G E C",
    "BEETHOVEN => C G D Ab F#",
    "BRAHMS => F Bb Db D Ab C Eb G C",
    "BRUCKNER => D Bb F G Eb C F#",
    "BERG => C#",
  ])
}
