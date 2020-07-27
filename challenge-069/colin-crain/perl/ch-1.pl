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

my ($A, $B) = @ARGV;              ## low, high bounds

# the order is the length of the half number that is modified and
# joined to itself, with or without the pivot digit in the
# center. Thus a given order will generate numbers up to 2n+1
# places long, or numbers up to but less than 10^(2n+1) The order
# is calculated to be large enough to create all numbers as large
# as B. As the maximum of the range scales by magnitude 100, the
# largest number created can still be quite a bit larger, but we
# can guarantee it will be large enough and also that none of the
# next larger order will be required. It serves as an upper bound
# to the calculation space.
my $order  = int(length($B)/2);

my @list   = (0, 1, 6, 8, 9);
my @center = (0, 1, 8);

my @num    = @list[1..@list-1];   ## remove leading 0
my @stereo = @center;             ## ensures trivial single digit cases

for (0..$order-1) {
    my @evens = my @odds  = ();   ## reset holding arrays

    for my $left (@num) {
        my $right = reverse($left =~ tr/69/96/r);
            push @evens, "$left$right";

        for my $center (@center) {
            push @odds, "$left$center$right";
        }
    }

    push @stereo, @evens, @odds;    ## keeps things sorted

    ## add another digit to the working list
    @num = map { my $c = $_; map "$c$_", @list } @num;
}

## output within the specified range
for ( @stereo ) {
    next if $_ < $A;
    last if $_ > $B;
    say $_;

}

## ## ## ## ## SUBS:

## included because I wanted to write a regex to find these numbers,
## but an impractical method in the end.
sub is_strobogrammatic {
    $_[0] =~ m/^([16890]+)[180]?((??{my $n=$1;$n=~tr[69][96];reverse($n)}))$/
                ? "$_[0] is strobogrammatic"
                : "$_[0] is not strobogrammatic"
}
