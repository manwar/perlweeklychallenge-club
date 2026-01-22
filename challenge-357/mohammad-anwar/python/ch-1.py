#!/usr/bin/env python3

def kaprekar_constant(n: int) -> int:
    seen = set()
    i = 0

    while n != 6174:
        if n in seen:
            return -1
        seen.add(n)

        s = f"{n:04d}"
        a = "".join(sorted(s))
        d = a[::-1]

        n = int(d) - int(a)
        i += 1

    return i


def main():
    examples = [
        {"in": 3524, "out": 3 },
        {"in": 6174, "out": 0 },
        {"in": 9998, "out": 5 },
        {"in": 1001, "out": 4 },
        {"in": 9000, "out": 4 },
        {"in": 1111, "out": -1},
    ]

    for e in examples:
        result = kaprekar_constant(e["in"])
        assert result == e["out"], f"Input {e['in']}: got {result}, expected {e['out']}"

    print("All tests passed")


if __name__ == "__main__":
    main()
