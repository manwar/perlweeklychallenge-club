import gleam/dict.{type Dict}
import gleam/int
import gleam/list
import gleam/result
import gleam/string

type Entry {
  Entry(depth: Int, name: String)
}

pub fn longest_absolute_path(fs: String) -> Int {
  let entries =
    string.split(fs, "\n")
    |> list.filter(fn(line) { line != "" })
    |> list.map(parse)
  walk(entries, dict.new(), 0)
}

fn parse(line: String) -> Entry {
  let name = trim_leading_tabs(line)
  Entry(string.length(line) - string.length(name), name)
}

fn trim_leading_tabs(s: String) -> String {
  case s {
    "\t" <> rest -> trim_leading_tabs(rest)
    _ -> s
  }
}

fn walk(entries: List(Entry), lens: Dict(Int, Int), best: Int) -> Int {
  case entries {
    [] -> best
    [Entry(depth, name), ..rest] -> {
      let len = parent_len(depth, lens) + string.length(name)
      let is_dir = case rest {
        [Entry(next_depth, _), ..] -> next_depth > depth
        [] -> False
      }
      let is_file = !is_dir && string.contains(name, ".")

      let best = case is_file {
        True -> int.max(best, len)
        False -> best
      }
      walk(rest, dict.insert(lens, depth, len), best)
    }
  }
}

fn parent_len(depth: Int, lens: Dict(Int, Int)) -> Int {
  case depth {
    0 -> 0
    d -> dict.get(lens, d - 1) |> result.unwrap(0) |> int.add(1)
  }
}
