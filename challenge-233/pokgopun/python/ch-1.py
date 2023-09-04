# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/
"""
Task 1: Similar Words

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of words made up of alphabets only.

   Write a script to find the number of pairs of similar words. Two words
   are similar if they consist of the same characters.

Example 1

Input: @words = ("aba", "aabb", "abcd", "bac", "aabc")
Output: 2

Pair 1: similar words ("aba", "aabb")
Pair 2: similar words ("bac", "aabc")

Example 2

Input: @words = ("aabb", "ab", "ba")
Output: 3

Pair 1: similar words ("aabb", "ab")
Pair 2: similar words ("aabb", "ba")
Pair 3: similar words ("ab", "ba")

Example 3

Input: @words = ("nba", "cba", "dba")
Output: 0
"""
def countSimilar (words):
    dct = {} ### key => word pattern, value => count
    for word in words:
        ### Convert word to set which will sort/dedup, and then to string to use as dict key
        k = str(set(word))
        if dct.get(k):
            dct[k] += 1
        else:
            dct[k] = 1
    #print(dct)
    ### pattern with count > 2 contains nC2 pair. Filter and calculate and return sum of pair
    return sum(
            list(
                map(
                    lambda x: fctrl(x) / ( 2 * fctrl(x-2) ),
                    filter( lambda x: x > 1, dct.values())
                    )
                )
            )

def fctrl(n):
  f = 1
  for i in range(2,n+1):
    f *= i
  return f
  
for words, count in {
        ("aba", "aabb", "abcd", "bac", "aabc"): 2,
        ("aabb", "ab", "ba"): 3,
        ("nba", "cba", "dba"): 0,
}.items():
    print(countSimilar(words)==count)
