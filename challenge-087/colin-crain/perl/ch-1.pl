#! /opt/local/bin/perl
#
#       longest_sequence.pl
#
#         TASK #1 › Longest Consecutive Sequence
#         Submitted by: Mohammad S Anwar
#         You are given an unsorted array of integers @N.
#
#         Write a script to find the longest consecutive sequence. Print 0 if none sequence found.
#
#         Example 1:
#             Input: @N = (100, 4, 50, 3, 2)
#             Output: (2, 3, 4)
#         Example 2:
#             Input: @N = (20, 30, 10, 40, 50)
#             Output: 0
#         Example 3:
#             Input: @N = (20, 19, 9, 11, 10)
#             Output: (9, 10, 11)
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## default CFG

scalar @ARGV == 0 and @ARGV = (100, 4, 50, 3, 2);

## ## ## ## ## MAIN:

my @input = sort { $a<=>$b } grep { /^\d+$/ } @ARGV;

my @run = shift @input;
my %out;


for my  $ele ( @input ) {
    if ($ele == $run[-1] + 1) {
        push @run, $ele;
    }
    else {
        $out{ scalar @run } = [ @run ];
    }
}
$out{ scalar @run } = [ @run ];

my $max = ( sort {$b<=>$a} keys %out )[0];

say "longest run is $max elements $out{$max}->@*";










## ## ## ## ## SUBS:

