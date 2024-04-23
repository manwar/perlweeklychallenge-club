from collections import Counter
from typing import Tuple


def uncommon_words(line1: str, line2: str) -> Tuple[str, ...]:
    """
    Find all uncommon words in any order in the given two sentences.

    Args:
    line1 (str): The first sentence.
    line2 (str): The second sentence.

    Returns:
    Tuple[str, ...]: A tuple of uncommon words. If none found, returns an empty tuple.
    """
    words1 = line1.split()
    words2 = line2.split()

    counter1 = Counter(words1)
    counter2 = Counter(words2)

    uncommon = [
        word for word in counter1 if counter1[word] == 1 and word not in counter2
    ]
    for word in counter2:
        if counter2[word] == 1 and word not in counter1:
            uncommon.append(word)

    return tuple(uncommon)


# Test cases
print(uncommon_words("Mango is sweet", "Mango is sour"))
# Output: ('sweet', 'sour')
print(uncommon_words("Mango Mango", "Orange"))
# Output: ('Orange')
print(uncommon_words("Mango is Mango", "Orange is Orange"))
# Output: ()
