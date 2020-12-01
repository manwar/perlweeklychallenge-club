#!/bin/env raku

=begin Challenge

Write a script to display matrix as below with numbers 1 - 9. Please make sure numbers are used once.

[ a b c ]
[ d e f ]
[ g h i ]

So that it satisfies the following:

a + b + c = 15
d + e + f = 15
g + h + i = 15
a + d + g = 15
b + e + h = 15
c + f + i = 15
a + e + i = 15
c + e + g = 15

=end Challenge

(1..9).permutations
    .grep({ all(
        .[0]+.[1]+.[2], .[3]+.[4]+.[5], .[6]+.[7]+.[8],
        .[0]+.[3]+.[6], .[1]+.[4]+.[7], .[2]+.[5]+.[8],
        .[0]+.[4]+.[8], .[2]+.[4]+.[6]
    ) == 15 })
    .map({ "{.[0]} {.[1]} {.[2]}\n{.[3]} {.[4]} {.[5]}\n{.[6]} {.[7]} {.[8]}" })
    .join("\n\n")
    .put;
