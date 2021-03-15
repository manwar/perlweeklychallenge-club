'''

TASK #1 › Reverse Words
Submitted by: Mohammad S Anwar
You are given a string $S.

Write a script to reverse the order of words in the given string. The string may contain leading/trailing spaces. The string may have more than one space between words in the string. Print the result without leading/trailing spaces and there should be only one space between words.

    Example 1:
        Input: $S = "The Weekly Challenge"
        Output: "Challenge Weekly The"
    Example 2:
        Input: $S = "    Perl and   Raku are  part of the same family  "
        Output: "family same the of part are Raku and Perl"

'''
import re

input = "    Perl and   Raku are  part of the same family  ";
listReverse = []
separator = " "

def fixSpaces(a):
    inputNew = a.strip()
    inputFinal = re.sub(' +', separator,inputNew)
    reverseString(inputFinal)

def reverseString(x):
    words = x.split(separator)
    for i in range(len(words)):
        listReverse.append(words[-1-i])
    sentence = separator.join(listReverse)
    print (sentence)

fixSpaces(input)





