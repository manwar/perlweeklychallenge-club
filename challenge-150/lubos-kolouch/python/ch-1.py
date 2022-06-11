def get_fib_word(word1: str, word2: str):
    """Generate the Fibonacci word"""

    while len(word2) < 51:
        new_word = word1 + word2
        word1, word2 = word2, new_word

    return word2[50]


assert get_fib_word("1234", "5678") == "7"
