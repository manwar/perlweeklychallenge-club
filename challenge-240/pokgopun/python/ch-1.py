### https://theweeklychallenge.org/blog/perl-weekly-challenge-240/
"""

Task 1: Acronym

Submitted by: [52]Mohammad S Anwar
     __________________________________________________________________

   You are given two arrays of strings and a check string.

   Write a script to find out if the check string is the acronym of the
   words in the given array.

Example 1

Input: @str = ("Perl", "Python", "Pascal")
       $chk = "ppp"
Output: true

Example 2

Input: @str = ("Perl", "Raku")
       $chk = "rp"
Output: false

Example 3

Input: @str = ("Oracle", "Awk", "C")
       $chk = "oac"
Output: true

Task 2: Build Array
"""
### solution by pokgopun@gmail.com

def isAbbrv(tup, abbrv):
    return abbrv.lower()=="".join(
            tuple(
                map(lambda x: x[0], tup
                    )
                )
            ).lower()

for (strings, abbrv), res in {
        (("Perl", "Python", "Pascal"),"ppp"): True,
        (("Perl", "Raku"), "rp"): False,
        (("Oracle", "Awk", "C"),"oac"): True,
        }.items():
    print(isAbbrv(strings, abbrv)==res)

