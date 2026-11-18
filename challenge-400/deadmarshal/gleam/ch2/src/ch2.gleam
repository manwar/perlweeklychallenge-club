import gleam/list
import gleam/set.{type Set}
import gleam/string

pub fn minimum_genetic_mutation(
  start: String,
  end: String,
  bank: List(String),
) -> Int {
  case start == end {
    True -> 0
    False -> {
      let valid = set.from_list(bank)
      case set.contains(valid, end) {
        False -> -1
        True -> bfs([start], set.delete(valid, start), end, 0)
      }
    }
  }
}

fn bfs(
  frontier: List(String),
  unvisited: Set(String),
  end: String,
  steps: Int,
) {
  case frontier {
    [] -> -1
    _ -> {
      let next =
        frontier
        |> list.flat_map(mutations)
        |> list.filter(set.contains(unvisited, _))
        |> list.unique
      case list.contains(next, end) {
        True -> steps + 1
        False ->
          bfs(
            next,
            set.difference(unvisited, set.from_list(next)),
            end,
            steps + 1,
          )
      }
    }
  }
}

fn mutations(gene: String) -> List(String) {
  let chars = string.to_graphemes(gene)

  chars
  |> list.index_map(fn(old, i) {
    let #(prefix, rest) = list.split(chars, i)
    let suffix = list.drop(rest, 1)
    ["A", "C", "G", "T"]
    |> list.filter(fn(c) { c != old })
    |> list.map(fn(c) { string.concat(list.flatten([prefix, [c], suffix])) })
  })
  |> list.flatten
}
