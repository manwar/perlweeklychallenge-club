#!/usr/bin/env perl6
#
#
#       155-1-fortunate-son.raku
#
#       method:

#         In Raku the process becomes one complex chained function. In the
#         first line w take the triangular reduction product of an infinite
#         prime sequence that has been sliced to the first $quan number of
#         elements, corresponding to the number of furtuante numbers we
#         want to create. This creates a list of primorials to work with.
# 
#         In the second line we map individual elements from that list to
#         the result of creating an infinite list of values starting at the
#         initial element value plus 2 and then finding the first prime
#         number in the sequence. The we subtract the initial value to
#         arrive at the difference, which is the fortunate number.
# 
#         Then we output the final list of fortunate numbers we've created.
# 
#         I love this data flow. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ($quan = 20) ;

    ([\*] ((1..*).grep: *.is-prime)[0..$quan])
        .map({($_+2...Inf).first(*.is-prime) - $_})
        .say ;
        


