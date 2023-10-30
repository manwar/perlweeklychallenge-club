### https://theweeklychallenge.org/blog/perl-weekly-challenge-234/
"""

Task 1: Common Characters

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of words made up of alphabetic characters only.

   Write a script to return all alphabetic characters that show up in all
   words including duplicates.

Example 1

Input: @words = ("java", "javascript", "julia")
Output: ("j", "a")

Example 2

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 3

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Task 2: Unequal Triplets
"""

def commonChars(words):
    ### store 1st word in a list of tuples to compare with the rest
    ### we cannot simply use map here because we need to accout for individual duplicated char, see Example 2
    ### each tuple contains a char and initial count 1

    word0Chars = [ (words[0][x],1) for x in range(len(words[0])) ]

    for word in words[1:]:    ### the remaining words to check against word0Chars

        for i in range(len(word0Chars)):

            c = word0Chars[i][0]   ### a char of word0 to check against word
            j = word.find(c)   ### find the char in word

            if j != -1:   ### if the char is found in word, increase its count in word0Chars, and then remove it from word

                word0Chars[i] = (c, word0Chars[i][1]+1) 
                word = word[:j] + word[j+1:]

    count = len(words)   ### count of common chars, this will use to filter word0Chars and map it create common chars
    return tuple(
            map(
                lambda x: x[0],
                filter(
                    lambda x: x[1]==count,
                    word0Chars
                    )
                )
            )

for inpt,otpt in {
        ("java", "javascript", "julia"): ("j", "a"), 
        ("bella", "label", "roller"): ("e", "l", "l"), 
        ("cool", "lock", "cook"): ("c", "o"),
        }.items():
    print(commonChars(inpt)==otpt)
