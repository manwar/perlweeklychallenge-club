#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# a (n) is the n'th non-negative integer which does not contain
# a 1. We start counting at 1, so a(1) is 0.
#
# See also A052383 (https://oeis.org/A052383)
#

#
# A052383 (n) is the replacement of all nonzero digits d by d + 1 in the
# base-9 representation of n - 1. - Reinhard Zumkeller, Oct 07 2014
#
sub A052383 ($n) {
    #
    # First turn ($n - 1) into base 9.
    #
    my $m = "";
    $n = $n - 1;
    while ($n) {
        $m .= $n % 9;
        $n  = ($n - ($n % 9)) / 9;
    }
    $m = reverse $m;

    #
    # Now, replace all non zero digits d by d + 1.
    #
    $m =~ y/1-8/2-9/;
    $m || 0;  # || 0 to handle the case $n = 1, which results in $m eq ""
}

#
# Given a number, return the largest number smaller or equal than the
# given number, which does not contain a one. We find this number by
# changing the first 1 in the input number to a 0, and changing each
# subsequent number into a 9.
#
# We'll also remove any possible leading 0 (which can happen if the
# input number starts with a 1, and handle the case where the input
# number is 1 (which would be an empty string after following the
# above procedure).
#
sub previous_no_one ($number) {
    $number =~ s/1([0-9]*)$/0 . ("9" x length $1)/er
            =~ s/^0+//r || 0;
}


while (my $n = <>) {
    chomp $n;
    #
    # Special case $n == 1:
    #
    if ($n == 1) {
        say 0;
        next;
    }

    #
    # First find the largest $m <= $n where $m doesn't not contain a 1.
    # If $n doesn't contain a 1, then $m == $n. There will be as many
    # 1-less numbers less than or equal to $m as there less than or 
    # equal to $n.
    #
    my $m = previous_no_one ($n);

    #
    # We don't want A052383 ($m). Instead, we want to find a $p such that
    # A052383 ($p) == $m. If n > 1, we know that A052383 (n) > n. So, we
    # will do a binary search, starting with (min, max) = (1, $m), looking
    # for $p.
    #

    my ($min, $max) = (1, $m);
    my  $mid;  # Named $p above.
    {
        $mid  = int (($min + $max) / 2);
        my $r = A052383 ($mid);
        last if $r == $m; # Winner!
        if ($r < $m) {$min = $mid + 1}
        else         {$max = $mid}
        redo;
    }
    
    #
    # A052383 counts 0, so we have to subtract 1 from the answer.
    #
    say $mid - 1;
}
