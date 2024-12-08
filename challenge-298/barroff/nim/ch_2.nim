import std/unittest

from std/math import sum

# run tests with following command:
# nim c -r ch_2.nim

type
  interval = array[2, int]

proc right_interval(intervals: openArray[interval]): seq[int] =
  var
    rp: int
  for i in 0..high(intervals):
    rp = -1
    for j in 0..high(intervals):
      if intervals[j][0] == intervals[i][1]:
        rp = j
        break
      if intervals[j][0] > intervals[i][1]:
        if rp == -1:
          rp = j
        elif intervals[j][0] < intervals[rp][0]:
          rp = j

    add(result, rp)

suite "right interval":
  test "[[3,4], [2,3], [1,2]]":
    check(right_interval([[3, 4], [2, 3], [1, 2]]) == @[-1, 0, 1])

  test "[[1,4], [2,3], [3,4]]":
    check(right_interval([[1, 4], [2, 3], [3, 4]]) == @[-1, 2, -1])

  test "[[1,2]]":
    check(right_interval([[1, 2]]) == @[-1])

  test "[[1,4], [2, 2], [3, 4]]":
    check(right_interval([[1, 4], [2, 2], [3, 4]]) == @[-1, 1, -1])
