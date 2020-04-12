#!/usr/bin/env perl

###########################################################################
# script name: ch-1-CORRECTED.pl                                          #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/         #
#                                                                         #
# Stepping Numbers                                                        #
#                                                                         #
# Write a script to accept two numbers between 100 and 999. It should     #
# then print all Stepping Numbers between them.                           #
#                                                                         #
# A number is called a stepping number if the adjacent digits have a      #
# difference of 1. For example, 456 is a stepping number but 129 is not.  #
#                                                                         #
###########################################################################

use strict;
use warnings;
use FindBin;

my @step = ();
my $UPPER_LIMIT = 1000;
my $LOWER_LIMIT = 99;

for (my $i = 1; $i < 10; ++$i) {
    if ($i < 8) { # UP UP
        push @step, ($i * 100) + ( $i + 1 ) * 10 + ($i + 2);
    }
    if ($i > 1 && $i < 10) { # DOWN DOWN
        push @step, ($i * 100) + ( $i - 1 ) * 10 + ($i - 2);
    }
    if ($i < 9) { # UP DOWN
        push @step, ($i * 100) + ( $i + 1 ) * 10 + $i;
    }
    push @step, ($i * 100) + ( $i - 1 ) * 10 + $i; # DOWN UP
}

@step = sort { $a <=> $b } @step;

if (
    scalar @ARGV != 2

        or $ARGV[0] !~ m|\A\d{3}\Z|
        or $ARGV[0] <  $LOWER_LIMIT
        or $ARGV[0] >  $UPPER_LIMIT

        or $ARGV[1] !~ m|\A\d{3}\Z|
        or $ARGV[1] <  $LOWER_LIMIT
        or $ARGV[1] >  $UPPER_LIMIT

       ) {
    print STDERR  "$FindBin::Script requires 2 arguments between 100 and 999.\n";
    exit(1);
}

my ($min, $max) = (0, 0);

if ($ARGV[0] < $ARGV[1]) {
    $min = $ARGV[0];
    $max = $ARGV[1];
} elsif ($ARGV[1] < $ARGV[0]) {
    $min = $ARGV[1];
    $max = $ARGV[0];
} else {
    $max = $min = $ARGV[0];
}

my $commaFlag = 0;

exit if $step[0] > $max or $step[-1] < $min;

LOOP:
foreach (@step) {
    if ($_ >= $min and $_ <= $max) {
        print ", " if $commaFlag;
        print "$_";
        $commaFlag = 1;
    } elsif ($commaFlag) {
        last LOOP;
    }
}

print "\n" if $commaFlag;
