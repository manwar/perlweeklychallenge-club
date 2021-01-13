#! /opt/local/bin/perl
#
#       lonely_ex.pl
#
#         TASK #2 › Lonely X
#         Submitted by: Mohammad S Anwar
#         You are given m x n character matrix consists of O and X only.
# 
#         Write a script to count the total number of X surrounded by O only.
#         Print 0 if none found.
# 
#         Example 1:
#         Input: [ O O X ]
#                [ X O O ]
#                [ X O O ]
# 
#         Output: 1 as there is only one X at the first row last column
#         surrounded by only O.
#         Example 2:
#         Input: [ O O X O ]
#                [ X O O O ]
#                [ X O O X ]
#                [ O X O O ]
# 
#         Output: 2
# 
#             a) First  X found at Row 1 Col 3.
# 
#             b) Second X found at Row 3 Col 4.
# 
#         
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";
## ## ## ## ## MAIN:

## in
my @input = @ARGV;
@input = qw(OOXO XOOO XOOX OXOO) if scalar @input == 0 ;
our $mat = [ map { [ split //, $_ ] } @input ];

## work
my @lonely;
for my $y (0..scalar @$mat-1) {
    for my $x (0..scalar @{$mat->[0]}-1) {
        if ($mat->[$y][$x] eq 'X' and is_lonely($x, $y)) {
            push @lonely, [$x, $y];
        }
    }
}

## out
say (join '  ', $_->@*) for $mat->@*;
for ( @lonely ) {
    my ($col, $row) = map { ++$_ } @$_;
    say "the X at column → $col, row down ↓ $row is lonely";
}

## ## ## ## ## SUBS:

sub is_lonely {
    my ($x, $y) = @_;
    
    for my $offset ([1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1],[0,-1],[1,-1]) {
        next if ($x + $offset->[0] < 0) || ($y + $offset->[1] < 0);
        next if ! defined $mat->[ $y + $offset->[1] ][ $x + $offset->[0] ];
        return 0 if $mat->[ $y + $offset->[1] ][ $x + $offset->[0] ] eq 'X';  
    }
    return 1;    
}