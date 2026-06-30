
def reverseDegree(s):
    cs = [1 + abs((ord(c) - 96) % -26) for c in s]
    return sum((i+1) * n for i, n in enumerate(cs))

assert reverseDegree("z")       == 1
assert reverseDegree("a")       == 26
assert reverseDegree("bbc")     == 147
assert reverseDegree("racecar") == 560
assert reverseDegree("zyx")     == 14
assert reverseDegree("")        == 0


