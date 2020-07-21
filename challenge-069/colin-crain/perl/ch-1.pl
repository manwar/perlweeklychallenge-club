#! /opt/local/bin/perl
#
#       stroboscope.pl
#
#         TASK #1 › Strobogrammatic Number
#         Submitted by: Mohammad S Anwar
#             A strobogrammatic number is a number that looks the same
#             when looked at upside down.
#
#             You are given two positive numbers $A and $B such that
#                 1 <= $A <= $B <= 10^15.
#
#             Write a script to print all strobogrammatic numbers
#             between the given two numbers.
#
#         Example
#             Input:  $A = 50, $B = 100
#             Output: 69, 88, 96
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my ($A, $B) = @ARGV;                  ## low, high bounds
# ($A, $B) = (1000, 2000000000);
# the order is the length of the half number that is modified and
# joined to itself, with or without the pivot digit in the center.
# Thus a given order will generate numbers up to 2n+1 places long, or
# 10^(2n+1) The order is calculated to theoretically create numbers as
# large as B. As this value scales by magnitude 100, this number can
# be quite a bit larger, but will larger and we can guarantee none of
# the next larger order will be required. It serves as an upper bound
# to the calculation space.
my $order  = int(length($B)/2);

my @list   = (0, 1, 6, 8, 9);
my @center = (0, 1, 8);

my @num    = @list[1..@list-1];       ## remove leading 0
my @stereo = grep { $_ >= $A && $_ <= $B } @center;                 ## single digit cases

OUTER: for (0..$order-1) {
    my @evens = my @odds  = ();       ## reset holding arrays

    for my $left (@num) {
        my $right = reverse($left =~ tr/69/96/r);

            my $even = "$left$right";
            if ($even > $B) {
                push @stereo, @evens, @odds;      ## keeps things sorted
                last OUTER;
            }
            push @evens, $even unless $even < $A;

        for my $center (@center) {
            my $odd = "$left$center$right";
            last if $odd > $B;
            next if $odd < $A;
            push @odds, $odd;
        }
    }


    ## add another digit to the working list
    @num = map { my $c = $_; map "$c$_", @list } @num;
}

# for ( @stereo ) {
#     next if $_ < $A;
#     last if $_ > $B;
#     say $_;
# }

say $_ for @stereo;




## ## ## ## ## SUBS:

## included because I wanted to write a regex to find these numbers,
## but an impractical method in the end.
sub is_strobogrammatic {
    $_[0] =~ m/^([16890]*)[180]?((??{reverse($1=~tr[69][96]r)}))$/ ? 1 : 0
}
