### https://theweeklychallenge.org/blog/perl-weekly-challenge-274/
"""

Task 1: Goat Latin

Submitted by: [57]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence, $sentance.

   Write a script to convert the given sentence to Goat Latin, a made up
   language similar to Pig Latin.

   Rules for Goat Latin:
1) If a word begins with a vowel ("a", "e", "i", "o", "u"), append
   "ma" to the end of the word.
2) If a word begins with consonant i.e. not a vowel, remove first
   letter and append it to the end then add "ma".
3) Add letter "a" to the end of first word in the sentence, "aa" to
   the second word, etc etc.

Example 1

Input: $sentence = "I love Perl"
Output: "Imaa ovelmaaa erlPmaaaa"

Example 2

Input: $sentence = "Perl and Raku are friends"
Output: "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa"

Example 3

Input: $sentence = "The Weekly Challenge"
Output: "heTmaa eeklyWmaaa hallengeCmaaaa"

Task 2: Bus Route
"""
### solution by pokgopun@gmail.com

def goatLatin(sentence: str):
    ws = [ e + "m" if e[0] in "aeiouAEIOU" else e[1:] + e[0] + "m" for e in sentence.split()]
    return " ".join(
            ws[i]+"a"*(i+2) for i in range(len(ws))
            )

import unittest

class TestGoatLatin(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                "I love Perl": "Imaa ovelmaaa erlPmaaaa",
                "Perl and Raku are friends": "erlPmaa andmaaa akuRmaaaa aremaaaaa riendsfmaaaaaa",
                "The Weekly Challenge": "heTmaa eeklyWmaaa hallengeCmaaaa",
                }.items():
            self.assertEqual(goatLatin(inpt),otpt)

unittest.main()
