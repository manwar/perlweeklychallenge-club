#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/         #
#                                                                         #
# Wave Array                                                              #
# Any array N of non-unique, unsorted integers can be arranged into a     #
# wave-like array such that n1 => n2 <= n3 => n4 <= n5 and so on.         #
# For example, given the array [1, 2, 3, 4], possible wave arrays         #
# include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 => 1 <= 4 => 3 <=         #
# and 4 => 1 <= 3 => 2. This is not a complete list.                      #
# Write a script to print all possible wave arrays for an integer array   #
# N of arbitrary length.                                                  #
#                                                                         #
# Notes:                                                                  #
# When considering N of any length, note that the first element is        #
# always greater than or equal to the second, and then the <= => <=       #
# sequence alternates until the end of the array.                         #
#                                                                         #
###########################################################################

use strict;
use warnings;

use List::Permutor;

my @n = (1,2,3,4);

if (@ARGV) {
    @n = ();
    my $argString = "@ARGV";

    my %pair = ( '[' => ']', '(' => '\)', '{' => '}', '<' => '>');
    $argString =~ s{\A\s*([[(\{<])\s*}{};
    $argString =~ s{\s*$pair{$1}\s*\Z}{} if $1;
    $argString =~ s{[, ]+}{ }g;

    foreach (split m{ }, $argString) {
        if ($_ =~ m{\d+}) {
            push @n, $_;
        } else {
            print STDERR "Non-numeric input detected.\n";
            exit(1);
        }
    }

} else {
    print STDERR "No arguments given. Using example data: [1, 2, 3, 4]\n";
}

my $perm = new List::Permutor @n;

ARRAY_LOOP:
while (my @set = $perm->next) {
    my $prev;

    ITEM_LOOP:
    for (my $i = 0; $i <= $#set; ++$i) {
        next ITEM_LOOP if $i == 0;

        if ($i % 2 == 0) {      # EVEN
            next ARRAY_LOOP if $set[$i-1] > $set[$i];
        } else {                # ODD
            next ARRAY_LOOP if $set[$i-1] < $set[$i];
        }
    }

    print "$_ " foreach @set;
    print "\n";
}
