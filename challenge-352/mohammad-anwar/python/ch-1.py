#!/usr/bin/env python3

def match_string(words):
    seen   = {}
    result = []

    for word in words:
        if word in seen:
            continue
        seen[word] = True

        for other in words:
            if other != word and word in other:
                result.append(word)
                break

    return result

if __name__ == "__main__":
    examples = [
        {
            "in": ["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"],
            "out": ["cat", "dog", "dogcat", "rat"]
        },
        {
            "in": ["hello", "hell", "world", "wor", "ellow", "elloworld"],
            "out": ["hell", "world", "wor", "ellow"]
        },
        {
            "in": ["a", "aa", "aaa", "aaaa"],
            "out": ["a", "aa", "aaa"]
        },
        {
            "in": ["flower", "flow", "flight", "fl", "fli", "ig", "ght"],
            "out": ["flow", "fl", "fli", "ig", "ght"]
        },
        {
            "in": ["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"],
            "out": ["car", "pet", "enter", "pen", "pent"]
        }
    ]

    for example in examples:
        result = match_string(example["in"])
        expected = example["out"]
        assert result == expected, f"Failed: got {result}, expected {expected}"

    print("All tests passed!")
