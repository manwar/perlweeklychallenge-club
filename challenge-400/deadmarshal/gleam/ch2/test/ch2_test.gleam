import ch2
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn minimum_genetic_mutation_test() {
  [
    #("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"]),
    #("AACCGGTT", "AACCGGAA", [
      "AACCGGTA",
      "AACCGGAA",
      "AACCGCTA",
      "AACCCTAA",
      "AACCGTAA",
    ]),
    #("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"]),
    #("GAAAAAAA", "GCCCCCCC", [
      "GCAAAAAA",
      "GCCAAAAA",
      "GCCCAAAA",
      "GCCCCAAA",
      "GCCCCCAA",
      "GCCCCCCA",
      "GCCCCCCC",
    ]),
    #("AACCGGTT", "AACCGGTT", ["AACCGGTA"]),
  ]
  |> list.map(fn(t) { ch2.minimum_genetic_mutation(t.0, t.1, t.2) })
  |> should.equal([-1, 2, -1, 7, 0])
}

