#!/usr/bin/env python3

def max_word(sentences):
    if not sentences:
        return 0
    return max(len(sentence.split()) for sentence in sentences)

examples = [
    {
        "in": ["Hello world", "This is a test", "Perl is great"],
        "out": 4
    },
    {
        "in": ["Single"],
        "out": 1
    },
    {
        "in": ["Short", "This sentence has seven words in total", "A B C", "Just four words here"],
        "out": 7
    },
    {
        "in": ["One", "Two parts", "Three part phrase", ""],
        "out": 3
    },
    {
        "in": ["The quick brown fox jumps over the lazy dog", "A",
               "She sells seashells by the seashore",
               "To be or not to be that is the question"],
        "out": 10
    },
]

for i, example in enumerate(examples, 1):
    result = max_word(example["in"])
    expected = example["out"]
    if result == expected:
        print(f"ok {i}")
    else:
        print(f"fail {i}")
