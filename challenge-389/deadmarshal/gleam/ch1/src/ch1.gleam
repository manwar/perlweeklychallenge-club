import gleam/int
import gleam/list
import gleam/string

pub type Melody {
  Melody(composer: String, notes: List(String), perms: List(Int))
}

fn permute(l: List(a), perms: List(Int)) -> List(a) {
  let #(_, res) =
    list.zip(perms, l)
    |> list.sort(by: fn(a, b) { int.compare(a.0, b.0) })
    |> list.unzip()
  res
}

pub fn reorder_notes(melody: Melody) -> String {
  let Melody(composer:, notes:, perms:) = melody
  let reordered = permute(notes, perms)
  string.uppercase(composer) <> " => " <> string.join(reordered, " ")
}
