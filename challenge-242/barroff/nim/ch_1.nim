import std/[sets, unittest]

# run tests with following command:
# nim c -r ch_1.nim

proc missing_members[T: SomeInteger](arr1: openArray[T], arr2: openArray[T]): (
    HashSet[T], HashSet[T]) =
  let
    set1 = toHashSet(arr1)
    set2 = toHashSet(arr2)
  result = (set1 - set2, set2 - set1)

suite "missing members":
  test "[1, 2, 3] and [2, 4, 6]":
    let
      arr1 = [1, 2, 3]
      arr2 = [2, 4, 6]
      res = (toHashSet([1, 3]), toHashSet([4, 6]))

    check(missing_members(arr1, arr2) == res)

  test "[1, 2, 3, 3] and [1, 1, 2, 2]":
    let
      arr1 = [1, 2, 3, 3]
      arr2 = [1, 1, 2, 2]
      res = (toHashSet([3]), toHashSet[int]([]))

    check(missing_members(arr1, arr2) == res)
