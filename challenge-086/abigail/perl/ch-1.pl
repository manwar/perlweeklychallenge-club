#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# Challenge
#
# You are given an array of integers @N and an integer $A.
#
# Write a script to find find if there exists a pair of elements in
# the array whose difference is $A.
#
# Print 1 if exists otherwise 0.
#

#
# This can be solved trivally by taking the difference of all
# pairs of numbers from @N, and see whether their difference
# equals $A. But that leads to a quadractic algorithm.
#
# But we can do this in linear time. For each element $x in @N,
# check with $A - $x exists in @N. Special care has to be taken
# in case $A - $x == $x: we have to make sure $x then appears 
# at least twice in @N.
#
# If we store the elements of @N in a hash, checking whether
# number exists in @N can be done in O (1) expected time.
#


LINE: while (!eof ()) {
    #
    # Read data:
    #   odd  lines are the numbers in @N
    #   even lines are the differences ($A).
    #
    my %data;
    $data {$_} ++ for <> =~ /[0-9]+/g;
    last if eof ();
    chomp (my $diff = <>);

    foreach my $number (keys %data) {
        my $target = $number - $diff;
        if ($data {$target} && ($diff || $data {$number} > 1)) {
            say 1;
            next LINE;
        }
    }

    say 0;
}


__END__
