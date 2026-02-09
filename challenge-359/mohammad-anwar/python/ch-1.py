#!/usr/bin/env python3

def digital_root_additive_persistence(num):
    if num < 10:
        return (0, num)

    digit_sum = sum(int(digit) for digit in str(num))
    count, root = digital_root_additive_persistence(digit_sum)

    return (count + 1, root)

if __name__ == "__main__":
    examples = {
        38: (2, 2),
        7: (0, 7),
        999: (2, 9),
        1999999999: (3, 1),
        101010: (1, 3),
    }

    all_passed = True
    for num, expected in examples.items():
        result = digital_root_additive_persistence(num)
        if result == expected:
            print(f"ok")
        else:
            all_passed = False

    print("\n" + ("All tests passed!" if all_passed else "Some tests failed!"))
