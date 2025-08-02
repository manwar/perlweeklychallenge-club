# Task 2: Most Frequent Word
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a paragraph $p and a banned word $w.
# Write a script to return the most frequent word that is not banned.
# 
# Example 1
# Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
#        $w = "hit"
# Output: "ball"
# 
# The banned word "hit" occurs 3 times.
# The other word "ball" occurs 2 times.
# 
# Example 2
# Input: $p = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
#        $w = "the"
# Output: "Perl"
# 
# The banned word "the" occurs 3 times.
# The other word "Perl" occurs 2 times.

def count(w, dictionary):
    if w in dictionary:
        dictionary[w] += 1
    else:
        dictionary.update({w: 1})

def banned_word(paragraph, banned):
    paragraph = filter(lambda x: x.isalnum() or x.isspace(), paragraph)
    paragraph = "".join(paragraph)

    dictionary = {}
    lst = paragraph.split()

    for w in lst:
        if w != banned:
            count(w, dictionary)

    print(max(dictionary, key=dictionary.get))

if __name__ == "__main__":
    paragraph = "Joe hit a ball, the hit ball flew far after it was hit."
    banned = "hit"
    banned_word(paragraph, banned)

    paragraph = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge."
    banned = "the"
    banned_word(paragraph, banned)
