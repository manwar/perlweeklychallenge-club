import gleam/int
import gleam/io
import gleam/list
import gleam/string

fn to_min(s: String) -> Int {
  let assert [hstr, mstr] = string.split(s, ":")
  let assert Ok(h) = int.parse(hstr)
  let assert Ok(m) = int.parse(mstr)
  h * 60 + m
}

fn convert_time(source: String, target: String) -> Int {
  let a = to_min(source)
  let b = to_min(target)
  let d = { b - a + 1440 } % 1440
  let #(res, _) =
    list.fold([60, 15, 5, 1], #(0, d), fn(step, e) {
      let #(total, remainder) = step
      #(total + { remainder / e }, remainder % e)
    })
  res
}

pub fn main() -> Nil {
  list.each(
    [
      ["02:30", "02:45"],
      ["11:55", "12:15"],
      ["09:00", "13:00"],
      ["23:45", "00:30"],
      ["14:20", "15:25"],
    ],
    fn(ss) {
      let assert [f, s] = ss
      convert_time(f, s)
      |> int.to_string
      |> io.println
    },
  )
}
