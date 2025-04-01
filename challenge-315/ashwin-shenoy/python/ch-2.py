import re

def solution(sentence: str, first_word: str, second_word: str) -> list[str]:
    """Solution to task 2.

    Title: "Find Third"

    You are given a sentence and two words.
    Write a script to return all words in the given sentence that appear in sequence to the given two words.

    URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-315/

    Algorithm details:

        Time complexity:

            - Best case scenario    : O(1)
            - Worst case scenario   : O(N)
            - Average case scenario : O(N)

        Space complexity:

            - Best case scenario    : O(1)
            - Worst case scenario   : O(N)
            - Average case scenario : O(N)

    Args:
        sentence: The given sentence.
        first_word: The first word.
        second_word: The second word.

    Returns:
        A list all words in the given sentence that appear in sequence to the given two words.
    """
    return re.findall(r"{}\s+{}\s+(?=(\w+))".format(first_word, second_word), sentence)


if __name__ == "__main__":
    print(
        f"Result: {solution('Perl is a my favourite language but Python is my favourite too.', 'my', 'favourite')}"
    )
