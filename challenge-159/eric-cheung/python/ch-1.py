## Remarks
## https://rosettacode.org/wiki/Four_is_magic#Python

from collections import OrderedDict
 
numbers = {1: 'one', 2: 'two', 3: 'three', 4: 'four', 5: 'five', 6: 'six', 7: 'seven', 8: 'eight', 9: 'nine'}

numbers = OrderedDict(sorted(numbers.items(), key = lambda t: t[0], reverse = True))

def string_representation(i: int) -> str:
    """
    Return the english string representation of an integer
    """
    if i == 0:
        return "zero"

    words = ['negative'] if i < 0 else []

    working_copy = abs(i)

    for key, value in numbers.items():
        if key <= working_copy:
            times = int(working_copy / key)
 
            if key >= 100:
                words.append(string_representation(times))

            words.append(value)
            working_copy -= times * key

        if working_copy == 0:
            break
 
    return " ".join(words)


def next_phrase(i: int):
    """
    Generate all the phrases
    """
    while not i == 4:  # Generate phrases until four is reached
        str_i = string_representation(i)
        len_i = len(str_i)

        yield str_i, "is", string_representation(len_i)

        i = len_i
 
    ## The Last Phrase
    yield string_representation(i), "is", "magic"
 
 
def magic(i: int) -> str:
    phrases = []

    for phrase in next_phrase(i):
        phrases.append(" ".join(phrase))

    return f'{", ".join(phrases)}.'.capitalize()


## Driver Code
 
## nInput = 5 ## Example 1:
## nInput = 7 ## Example 2:
nInput = 6 ## Example 3:
    
strMsg = magic(nInput)

print (strMsg)

