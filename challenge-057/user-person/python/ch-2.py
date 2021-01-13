#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-057/         #
#                                                                         #
# Shortest Unique Prefix                                                  #
# Write a script to find the shortest unique prefix for each each word    #
# in the given list. The prefixes will not necessarily be of the same     #
# length.                                                                 #
#                                                                         #
# Sample Input                                                            #
# [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]         #
# Expected Output                                                         #
# [ "alph", "b", "car", "cadm", "cade", "alpi" ]                          #
#                                                                         #
###########################################################################

def charsMatch(string1, string2):
    count = 0
    limit = 0
    s1 = list(string1) 
    s2 = list(string2) 
    
    if len(s2) > len(s1):
        limit = len(s1)
    else:
        limit = len(s2)

    for i in range(limit-1):
        if s1[i] == s2[i]:
            count += 1
        else:
            break
    if count + 1 < limit:
        count += 1
        
    return count

unSorted = ['alphabet', 'book', 'carpet', 'cadmium', 'cadeau', 'alpine']
prefix = {}

sortedList = sorted(unSorted)
diff = 0

for i in range(len(sortedList)):
    if i == 0:
        diff = charsMatch( sortedList[i], sortedList[i+1] )
    elif i == len(sortedList)-1:
        diff = charsMatch( sortedList[ len(sortedList)-2 ], sortedList[ len(sortedList)-1 ] )
    else:
        before = charsMatch( sortedList[i-1], sortedList[i] )
        after  = charsMatch( sortedList[i],   sortedList[i+1] )
        if before > after:
            diff = before
        else:
            diff = after
    prefix[ sortedList[i] ] = sortedList[i][:diff] 

print('[ ',end='')
for j in range(len(unSorted)):
    if j > 0:
        print(', ', end='')
    print('"' + prefix[ unSorted[j] ] + '"', end='')
print(']')

# output:
#
# [ "alph", "b", "car", "cadm", "cade", "alpi"]
