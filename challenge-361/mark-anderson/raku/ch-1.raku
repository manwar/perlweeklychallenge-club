#!/usr/bin/env raku
use JSON::Fast;
use Test;

is-deeply zeckendorf(4),   (3,1);
is-deeply zeckendorf(12),  (8,3,1);
is-deeply zeckendorf(20),  (13,5,2);
is-deeply zeckendorf(96),  (89,5,2);
is-deeply zeckendorf(100), (89,8,3);

is-deeply zeckendorf(1),   (1,);
is-deeply zeckendorf(89),  (89,);
is-deeply zeckendorf(144), (144,);
is-deeply zeckendorf(145), (144,1);
is-deeply zeckendorf(146), (144,2);
is-deeply zeckendorf(147), (144,3);
is-deeply zeckendorf(148), (144,3,1);
is-deeply zeckendorf(149), (144,5);

my $googol = 10**100;
is zeckendorf($googol).sum, $googol;

# I couldn't figure out why there was the requirement that $i
# be <= 100 (the Zeckendorf representation for googol can be 
# calculated without breaking a sweat) but after looking into 
# it some more there is a technique where you can use a lookup 
# table https://leancrew.com/all-this/2026/01/a-zeckendorf-table/
# which works well for $i <= 100

# Also see Will Coleda's Math::Zeckendorf module :) 

multi zeckendorf($i where $i <= 100)
{
    (from-json $=finish).grep($i (elem) *)>>.head.reverse
}

multi zeckendorf($i is copy)
{
    do while $i
    {
        my @f = 0,1,*+*...*+* > $i;
        $i -= @f.tail;
        @f.tail
    } 
}

=finish

[
[1, 4, 6, 9, 12, 14, 17, 19, 22, 25, 27, 30, 33, 35,
38, 40, 43, 46, 48, 51, 53, 56, 59, 61, 64, 67, 69,
72, 74, 77, 80, 82, 85, 88, 90, 93, 95, 98],

[2, 7, 10, 15, 20, 23, 28, 31, 36, 41, 44, 49, 54,
 57, 62, 65, 70, 75, 78, 83, 86, 91, 96, 99],

[3, 4, 11, 12, 16, 17, 24, 25, 32, 33, 37, 38, 45,
 46, 50, 51, 58, 59, 66, 67, 71, 72, 79, 80, 87, 88,
 92, 93, 100],

[5, 6, 7, 18, 19, 20, 26, 27, 28, 39, 40, 41, 52, 53,
 54, 60, 61, 62, 73, 74, 75, 81, 82, 83, 94, 95, 96],

[8, 9, 10, 11, 12, 29, 30, 31, 32, 33, 42, 43, 44,
 45, 46, 63, 64, 65, 66, 67, 84, 85, 86, 87, 88, 97,
 98, 99, 100],

[13, 14, 15, 16, 17, 18, 19, 20, 47, 48, 49, 50, 51,
 52, 53, 54, 68, 69, 70, 71, 72, 73, 74, 75],

[21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88],

[34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,
 47, 48, 49, 50, 51, 52, 53, 54],

[55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67,
 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
 81, 82, 83, 84, 85, 86, 87, 88],

[89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100]
]
