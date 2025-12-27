def max_words_in_sentences(sentences):
    max_count = 0

    for s in sentences:
        words = s.split()
        count = len(words)
        if count > max_count:
            max_count = count

    return max_count


def show_result(sentences):
    print('Input: sentences = ("' + '", "'.join(sentences) + '")')

    max_count = max_words_in_sentences(sentences)
    print("Output:", max_count)
    print()


# Example 1
sentences1 = ["Hello world", "This is a test", "Perl is great"]
show_result(sentences1)

# Example 2
sentences2 = ["Single"]
show_result(sentences2)

# Example 3
sentences3 = ["Short", "This sentence has seven words in total", "A B C", "Just four words here"]
show_result(sentences3)

# Example 4
sentences4 = ["One", "Two parts", "Three part phrase", ""]

# Example 5
sentences5 = [
    "The quick brown fox jumps over the lazy dog",
    "A",
    "She sells seashells by the seashore",
    "To be or not to be that is the question",
]
show_result(sentences5)
