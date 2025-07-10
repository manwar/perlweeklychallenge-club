import sys
from string import ascii_letters
import random
from enum import IntEnum

def longest_nice_substring(string: str) -> str:

    # longest nice substring found so far
    longest_nice_substring: str = ''

    # characters that we know can't form part of a not yet found nice substring
    never_nice: set[str] = set(string) - set(string.swapcase())

    # loop over starting indexes while it is possible to find a longer nice substring
    next_starting_index: int = 0
    while len(string) - next_starting_index > len(longest_nice_substring):
        starting_index: int = next_starting_index
        c: str = string[starting_index]
        next_starting_index += 1

        # can we rule out any substring starting here?
        if c in never_nice:
            continue
        # shortest substring that may be nice will end with the opposite character
        ending_index: int = string.find(c.swapcase(), next_starting_index) + 1
        if ending_index == 0:
            never_nice.add(c)
            continue

        # what we know so far about substrings starting at this starting index
        substring_prefix: str = string[starting_index:ending_index]
        nice: set[str] = set(substring_prefix) & set(substring_prefix.swapcase())
        not_yet_nice: set[str] = set(substring_prefix) - nice

        # found a nice substring?
        if not not_yet_nice:
            if len(substring_prefix) > len(longest_nice_substring):
                longest_nice_substring = substring_prefix
            # any nice strings starting in the middle of or just after this nice
            # string will also be nice if started at the beginning of it, so
            # this iteration of the outer loop will find them and the next
            # iteration can be farther on
            next_starting_index = ending_index + 1

        # look for longer nice substrings starting at this starting index
        for ending_index in range(ending_index, len(string)):
            c = string[ending_index]

            # character we know there's no match for later?
            if c in never_nice:
                break

            # character not yet seen in this substring?
            if c not in nice and c not in not_yet_nice:
                # completes an upper/lower pair?
                c_opposite: str = c.swapcase()
                if c_opposite in not_yet_nice:
                    not_yet_nice.remove(c_opposite)
                    nice.update(c, c_opposite)
                else:
                    not_yet_nice.add(c)

            # found a nice substring?
            if not not_yet_nice:
                if ending_index - starting_index >= len(longest_nice_substring):
                    longest_nice_substring = string[starting_index:ending_index+1]
                # any nice strings starting in the middle of or just after this
                # nice string will also be nice if started at the beginning of
                # it, so this iteration of the outer loop will find them and the
                # next iteration can be farther on
                next_starting_index = ending_index + 2

    return longest_nice_substring

def simple_longest_nice_substring(string: str) -> str:
    longest_nice_substring: str = ''
    for starting_index in range(0, len(string)):
        nice: set[str] = set()
        not_yet_nice: set[str] = set()
        for ending_index in range(starting_index, len(string)):
            c: str = string[ending_index]
            if c not in nice and c not in not_yet_nice:
                if c.swapcase() in not_yet_nice:
                    not_yet_nice.remove(c.swapcase())
                    nice.update(c, c.swapcase())
                else:
                    not_yet_nice.add(c)
            if not not_yet_nice and ending_index - starting_index + 1 > len(longest_nice_substring):
                longest_nice_substring = string[starting_index:ending_index+1]
    return longest_nice_substring

def main() -> None:
    inputs: list[str] = sys.argv[1:]

    # if given command line arguments, do those
    if len(inputs):
        for string in inputs:
            print(f'{string:<30} -> {longest_nice_substring(string)}')

    # otherwise, run an endless test of random values, comparing to simple version (stopping if an unexpected difference was found)
    else:
        checked: int = 0
        while True:
            checked += 1
            string = ''.join(random.choice(ascii_letters) for i in range(random.randint(0,200)))
            if simple_longest_nice_substring(string) != longest_nice_substring(string):
                print(f'string:  {string}\nsimple:  {simple_longest_nice_substring(string)}\ncomplex: {longest_nice_substring(string)}')
                break
            if checked % 1000 == 0:
                print(f'{checked}', end='\r')

if __name__ == '__main__':
    main()
