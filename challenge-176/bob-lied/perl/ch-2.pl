#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Task 2 Reversible Numbers
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Write a script to find out all Reversible Numbers below 100.
# A number is said to be a reversible if sum of the number and its
# reverse had only odd digits.
# For example,
# 36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
# 17 is not reversible as 17 + 71 = 88, none of the digits are odd.
#=============================================================================

use v5.36;

use builtin qw/true false/;
no warnings "experimental::builtin";

# To be an odd number, it has to be the sum of an even and an odd number.
# We're considering only two-digit numbers, so that means if the first digit
# is odd, the second must be even, and vice versa.  Generate the possibilities.
my @candidate = ( glob("{1,3,5,7,9}{0,2,4,6,8}"), glob("{2,4,6,8}{1,3,5,7,9}") );

say join ",", sort { $a <=> $b }
                grep { $_ < 100 && allOdd($_ + revNum($_)) } @candidate;

# There are two fairly obvious ways of reversing the number.  We can treat
# it as a string and reverse the digits, or we can do the math.  The string
# operations are actually faster.
sub revNum($n)
{
    (my $r = reverse("$n")) =~ s/^0+//;
    return +($r);
}

# Checking that all digits are odd.  Again, two possibilities:  do the math
# one digit at a time, or treat as a string and test each digit.
sub allOdd($n)
{
    my $isOdd = true; # Doesn't handle 0, but 0 is not happening here.
    while ( $n && $isOdd )
    {
        $isOdd &&= ( $n % 10 ) % 2;
        $n = int($n / 10);
    }
    return $isOdd;
}

sub allOdd_str($n)
{
    use List::Util qw/all/;
    return all { $_ % 2 } split("", $n);
}
