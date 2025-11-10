#!/usr/bin/env python3

def valid_longest_parenthesis(s):
    stack = [-1]
    max_len = 0

    for i in range(len(s)):
        if s[i] == "(":
            stack.append(i)
        else:
            stack.pop()
            if stack:
                max_len = max(max_len, i - stack[-1])
            else:
                stack.append(i)  # New starting point

    return max_len

def test_examples():
    examples = [
        {"str": "(()())",        "exp": 6},
        {"str": ")()())",        "exp": 4},
        {"str": "((()))()(((()", "exp": 8},
        {"str": "))))((()(",     "exp": 2},
        {"str": "()(()",         "exp": 2},
    ]

    for example in examples:
        result = valid_longest_parenthesis(example["str"])
        expected = example["exp"]
        assert result == expected, f"Failed for '{example['str']}': expected {expected}, got {result}"
        print(f"✓ '{example['str']}' -> {result}")

if __name__ == "__main__":
    test_examples()
    print("All tests passed!")
