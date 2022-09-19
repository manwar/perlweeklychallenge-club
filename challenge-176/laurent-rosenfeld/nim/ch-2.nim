import strutils
import algorithm

proc is_reversible(n: int): bool =
  # A Nim string is a sequence of chars, so that a cast will
  # split the string into individual chars
  let rev = parseInt(join(@(intToStr(n)).reversed(), ""))
  var sum = n + rev
  while sum > 0:
    let k = sum mod 10
    if (k mod 2 == 0):
      return false
    sum = (sum / 10).int
  return true


for i in 1..100:
  if is_reversible(i):
    stdout.write i, " "
echo ""
