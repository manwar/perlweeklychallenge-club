def word_break(s, words):
    word_set = set(words)
    length = len(s)
    dp = [False] * (length + 1)
    dp[0] = True  # Empty string can be segmented

    for i in range(1, length + 1):
        for j in range(i):
            if dp[j] and s[j:i] in word_set:
                dp[i] = True
                break

    return 'true' if dp[length] else 'false'


# Test cases
test_cases = [
    {
        'str': 'weeklychallenge',
        'words': ['challenge', 'weekly'],
        'expected': 'true'
    },
    {
        'str': 'perlrakuperl',
        'words': ['raku', 'perl'],
        'expected': 'true'
    },
    {
        'str': 'sonsanddaughters',
        'words': ['sons', 'sand', 'daughters'],
        'expected': 'false'
    },
    {
        'str': 'applepenapple',
        'words': ['apple', 'pen'],
        'expected': 'true'
    },
    {
        'str': 'catsandog',
        'words': ['cats', 'dog', 'sand', 'and', 'cat'],
        'expected': 'false'
    },
]

for test in test_cases:
    result = word_break(test['str'], test['words'])
    print(f"Input: str = \"{test['str']}\", words = {test['words']}")
    print(f"Output: {result}")
    print(f"Expected: {test['expected']}")
    print("-" * 40)
