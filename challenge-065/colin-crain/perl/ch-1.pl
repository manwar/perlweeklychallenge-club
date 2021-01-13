#! /opt/local/bin/perl
#
#       digikey_values.pl
#
#         TASK #1 › Digits Sum
#         Submitted by: Mohammad S Anwar
#         Tuned and Tweaked by: Ryan Thompson
#
#             You are given two positive numbers $N and $S.
#
#             Write a script to list all positive numbers having exactly
#             $N digits where sum of all digits equals to $S.
#
#             Example
#             Input:
#
#                 $N = 2
#                 $S = 4
#
#             Output:
#                 13, 22, 31, 40
#
# # # # # # # # #
#
#       METHOD
#
#           Perl has the wonderful ability to seamlessly glide between
#           looking at individual digits as either raw glyphs or atomic
#           numbers. In certain circumstances this peculiar eye is even
#           extended to other, non-digit characters. As such we can
#           assemble arbitrary digits, so as to positionally represent
#           numbers, in exactly the same way we would do so with a
#           pencil and paper.
#
#           This ability to construct strings of digits and such, and
#           then evaluate those strings as representing numbers, opens
#           up all kinds of questions of arithmetic number theory. Not
#           cleanly fitting into the more common sub-disciplines, one
#           might call it positional number theory, or as I like to call
#           it (after its poetic cognate), Concrete Number Theory. We
#           are no longer looking at just the meaning of the number, but
#           also how it looks on the page.
#
#           To solve the challenge, we will need to construct a list of
#           all numbers of a given positional length. For any given
#           length, that list starts at a number constructed with a 1
#           and 0s to fill out the span, and ends with a string of 9s.
#           We will need to make an exception of the numbers of length
#           1, that list spans from 0 to 9. We can then filter our list
#           with a function that sums the digits to allow elements that
#           match the desired value. To sum the digits, we take a number
#           and break it apart as we would a string into non-positional
#           digits again, iterating through the list produced and
#           summing to a collector. We could bring in List::Util::sum to
#           replace these two lines with one, but I hardly see the
#           point.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($digit_count, $target) = @ARGV;
$digit_count //=  4;
$target      //= 25;


my $start = ($digit_count == 1 ? '0' : '1' ). ( '0' x ($digit_count - 1));
my $end   = '9' x $digit_count;

my @result_set = grep { sum_digits($_) == $target } ($start..$end);

if (@result_set) {
    say $_ for @result_set;
}
else {
    say "there are no numbers of length $digit_count whose digits sum to $target";
}

## ## ## ## ## SUBS:

sub sum_digits {
    my @digits = split //, $_[0];
    my $sum;
    $sum += $_ for @digits;
    return $sum;
}
