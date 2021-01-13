#!/usr/bin/perl
use strict;
use warnings;
use feature 'say';
# Rotate Matrix
# Write a script to rotate the followin matrix by given 90/180/270 degrees clockwise.
# [ 1, 2, 3 ]
# [ 4, 5, 6 ]
# [ 7, 8, 9 ]
# For example, if you rotate by 90 degrees then expected result should be like below
# [ 7, 4, 1 ]
# [ 8, 5, 2 ]
# [ 9, 6, 3 ]

my @matrix = (
    [ 1, 2, 3 ],
    [ 4, 5, 6 ],
    [ 7, 8, 9 ],
);

#Obfuscated routine to rotate array 90cw, because it's perl. :D
sub rotate {@{$_[0]}=map[map$_[0]->[-$_][$'],//..@{$_[0]}],0..~-@{$_[0]->[0]}}
rotate (\@matrix) for 1..($ARGV[0]||90)/90 % 4;
map {say "@{$_}"} @matrix;
=begin
perl .\ch-1.pl 90
7 4 1
8 5 2
9 6 3

perl .\ch-1.pl 180   
9 8 7
6 5 4
3 2 1

perl .\ch-1.pl 270   
3 6 9
2 5 8
1 4 7

perl .\ch-1.pl 360   
1 2 3
4 5 6
7 8 9
=cut