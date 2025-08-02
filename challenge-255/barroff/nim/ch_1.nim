import std/[sugar, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc odd_character(s, t: string): char =
  let
    s_split = collect:
      for c in s: c
    t_split = collect:
      for c in t: c

  for i in 0..<len(s):
    if s_split[i] != t_split[i]:
      return t_split[i]
  return t_split[^1]

suite "odd character":
  test "Perl":
    check(odd_character("Perl", "Peerl") == 'e')

  test "Weekly":
    check(odd_character("Weekly", "Weeakly") == 'a')

  test "Box":
    check(odd_character("Box", "Boxy") == 'y')
