import sys

#https://stackoverflow.com/questions/65271060/is-there-a-built-in-way-to-use-inline-c-code-in-python

# cffi? https://stackoverflow.com/questions/65271060/is-there-a-built-in-way-to-use-inline-c-code-in-python
# python benchmarks

# ch-2: perl using List::BinarySearch and Judy1

def make_regex_search(r):
    def regex_search(binary_list):
        match = r.search(''.join(['1' if value==1 else '0' for value in binary_list]))
        result = 0 if not match else len(match.group(1))
        return result
    return regex_search

import re
naive_regex = make_regex_search(re.compile('(1+)(?!.*?\\1)'))

better_regex = make_regex_search(re.compile('(?<!1)(1++)(?!.*?\\1)'))

# re does not support branch reset or SKIP, re and regex do not support MARK
import pcre2
one_pass_regex = make_regex_search(pcre2.compile('(?|(1++).*?(*MARK:go)\\1(*SKIP:go)(*FAIL)|(1++))'))

def loop(binary_list):
    current_sequence = 0;
    longest_sequence = 0;
    for value in binary_list:
        if value:
            current_sequence += 1
        else:
            if longest_sequence < current_sequence:
                longest_sequence = current_sequence
            current_sequence = 0
    if longest_sequence < current_sequence:
        longest_sequence = current_sequence
    return longest_sequence

def loop_sentinel(binary_list):
    current_sequence = 0;
    longest_sequence = 0;
    for value in (*binary_list, 0):
        if value:
            current_sequence += 1
        else:
            if longest_sequence < current_sequence:
                longest_sequence = current_sequence
            current_sequence = 0
    return longest_sequence

#binary_list = [1 if value=='1' else 0 for value in sys.argv[1:]]
from digits import digits as binary_list
print(loop(binary_list))
print(loop_sentinel(binary_list))
print(naive_regex(binary_list))
print(better_regex(binary_list))
print(one_pass_regex(binary_list))
