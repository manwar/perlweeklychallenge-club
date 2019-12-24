#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given two or more arrays. Write a script to display values of each list at a given index.
For example:
Array 1: [ I L O V E Y O U ]
Array 2: [ 2 4 0 3 2 0 1 9 ]
Array 3: [ ! ? £ $ % ^ & * ]

We expect the following output:

I 2 !
L 4 ?
O 0 £
V 3 $
E 2 %
Y 0 ^
O 1 &
U 9 *
=cut
use utf8; # Source file encoding.

binmode (STDOUT, ":encoding(cp850)"); # '£' in Windows cmd.

my @arr_1 = qw(I L O V E Y O U);
my @arr_2 = qw(2 4 0 3 2 0 1 9);
my @arr_3 = qw(! ? £ $ % ^ & *);


for my $i ( 0 .. $#arr_1 )
{

     print join(' ', $arr_1[$i], $arr_2[$i], $arr_3[$i]), $/;
}
print "Now cheating with module: $/";



use List::MoreUtils qw(zip6);
print "@$_$/"for zip6 @arr_1, @arr_2, @arr_3;