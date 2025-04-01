def solution(words_list: list[str], character: str) -> list[int]:
    """Solution to task 1.

    Title: "Find Words"

    You are given a list of words and a character.
    Write a script to return the index of word in the list where you find the given character.

    URL: https://theweeklychallenge.org/blog/perl-weekly-challenge-315/

    Algorithm details:

        Time complexity:

            - Best case scenario    : O(N)
            - Worst case scenario   : O(N²)
            - Average case scenario : O(N²)

        Space complexity:

            - Best case scenario    : O(1)
            - Worst case scenario   : O(N)
            - Average case scenario : O(N)

    Args:
        words_list: The list of words.
        character: The character to search for (in each word) in the list of words.

    Returns:
        A list of indexes of word in the list where you find the given character.
    """
    words_index = []

    for idx, word in enumerate(words_list):
        if character in word:
            words_index.append(idx)

    return words_index


if __name__ == "__main__":
    print(f"Result: {solution(['abc', 'def', 'bbb', 'bcd'], 'b')}")
