#!/usr/bin/env python3

import unittest

examples = {
    4: "3,1",
    12: "8,3,1",
    20: "13,5,2",
    96: "89,5,2",
    100: "89,8,3",
}

def zeckendorf(n):
    f = [1, 2]

    while f[-1] <= n:
        f.append(f[-1] + f[-2])
    f.pop()
    r = []
    i = len(f) - 1
    while i >= 0:
        if f[i] <= n:
            r.append(f[i])
            n -= f[i]
        i -= 1

    return ",".join(str(x) for x in r)

class TestZeckendorf(unittest.TestCase):
    def test_examples(self):
        for key, value in examples.items():
            self.assertEqual(zeckendorf(key), value)

if __name__ == "__main__":
    unittest.main()
