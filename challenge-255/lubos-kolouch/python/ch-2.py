def most_frequent_word(p: str, w: str) -> str:
    """
    Find the most frequent word in a paragraph excluding a specific word.

    :param p: Paragraph as a string.
    :param w: Banned word.
    :return: Most frequent word.
    """
    import re
    from collections import Counter

    # Clean and split the paragraph into words
    words = re.findall(r"\w+", p.lower())

    # Count the frequency of each word, excluding the banned word
    word_count = Counter(words)
    if w in word_count:
        del word_count[w]

    # Find the most frequent word
    most_frequent = word_count.most_common(1)[0][0]

    return most_frequent


# Test cases
print(
    most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit.", "hit")
)
print(
    most_frequent_word(
        "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.",
        "the",
    )
)
