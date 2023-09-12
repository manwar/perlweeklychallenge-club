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

def commonChars(tup):
    ### create a ref list of character's count from the first word
    #ccLst = [ [tup[0][x],1] for x in range(len(tup[0])) ]
    ### change the type of list member from list to tuple
    ccLst = [ (tup[0][x],1) for x in range(len(tup[0])) ]

    ### the remaining words will have its characters checked against the ref list
    for word in tup[1:]:

        ### create a list of characters from the remaining word
        cLst = [word[x] for x in range(len(word))]

        for i in range(len(ccLst)):

            ### get a character from the ref list
            c = ccLst[i][0]

            ###  check if the remaining word contain the character
            if c in word:

                ### increase character's count in the ref list
                #ccLst[i][1] += 1
                ### as the ref list has its member type changed from list to tuple, need to recreate the tuple member
                ccLst[i] = (ccLst[i][0], ccLst[i][1]+1)

                ### remove the characer that has been counted
                cLst.remove(c)
                ### updating the remaining word
                word = "".join(cLst)

    ### count of common characters, this will use to filter ccList
    count = len(tup)
    ### filter ccList and then map to create the tuple of common characters
    return tuple(
            map(
                lambda x: x[0],
                filter(
                    lambda x: x[1]==count,
                    ccLst
                    )
                )
            )

for inpt,otpt in {
        ("java", "javascript", "julia"): ("j", "a"), 
        ("bella", "label", "roller"): ("e", "l", "l"), 
        ("cool", "lock", "cook"): ("c", "o"),
        }.items():
    print(commonChars(inpt)==otpt)


