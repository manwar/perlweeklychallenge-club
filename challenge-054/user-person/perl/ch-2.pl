#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/         #
#                                                                         #
# Collatz Conjecture                                                      #
# Contributed by Ryan Thompson                                            #
#                                                                         #
# It is thought that the following sequence will always reach 1:          #
# $n = $n / 2 when $n is even                                             #
# $n = 3*$n + 1 when $n is odd                                            #
#                                                                         #
# For example, if we start at 23, we get the following sequence:          #
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1   #
#                                                                         #
# Write a function that finds the Collatz sequence for any positive       #
# integer.                                                                #
# Notice how the sequence itself may go far above the original starting   #
# number.                                                                 #
#                                                                         #
# Extra Credit                                                            #
# Have your script calculate the sequence length for all starting numbers #
# up to 1000000 (1e6), and output the starting number                     #
# and sequence length for the longest 20 sequences.perl                   #
#                                                                         #
###########################################################################

use strict;
use warnings;
use diagnostics;
use FindBin;

++$|;

sub msgExit {
    print $FindBin::Script, " requires one positive integer as an argument (or extracredit).\n";
    exit(1);
}

my %high = ();

sub checkHighKeys {
    my $key = $_[0];
    my $keyCount = $_[1];
    my $highKeys = $_[2];

    if (keys %$highKeys == 20) {
        my $keyToLowest = (sort {$highKeys->{$a} <=> $highKeys->{$b} or $a <=> $b } keys %$highKeys)[0];
        if ($highKeys->{$keyToLowest} < $keyCount) {
            delete $highKeys->{$keyToLowest};
            $highKeys->{$key} = $keyCount;
        } elsif ($highKeys->{$keyToLowest} == $keyCount) {
            if ($keyToLowest < $key) {
                delete $highKeys->{$keyToLowest};
                $highKeys->{$key} = $keyCount;
            }
        }
    } else {
        $highKeys->{$key} = $keyCount;
    }
}

msgExit if scalar @ARGV != 1;

my $n = $ARGV[0];
my $extraCredit = 0;

if ($n =~ m{-{0,2}extra[-~`!@#$%^&*=+|\\;:'",.?/ ]?credit}i) {
    $n = 2;
    $extraCredit = 1;
    print STDERR "Allow time for calculations.\n";
    print STDERR "        They finish when '#'s reach this point-> |\n";
} elsif ($n =~ m{\A\d+\Z}) {
    msgExit if $n < 1;
} else {
    msgExit;
}

my $MAX = 1_000_000;
my $i = $n;

OUTER_LOOP:
while ($i <= $MAX) {
    my $count = 0;

    while ($n != 1) {

        if ($extraCredit) {
            $count++;
        } else {
            print "$n -> ";
        }

        if ($n % 2 == 0) {          # EVEN
            $n /= 2;
        } else {                    # ODD
            $n = 3*$n + 1;
        }
    }

    if ($extraCredit) {
        checkHighKeys( $i, $count, \%high);
        $n = ++$i;
        if ($n % 20_000 == 0) {
            print STDOUT "#";
        }
    } else {
        print "1\n";
        last OUTER_LOOP;
    }
}

if ($extraCredit) {
    print STDERR "\n\n";
    foreach my $key (sort { $high{$b} <=> $high{$a} or $b <=> $a } keys %high) {
        print "Starting number: ", $key, " with sequence length: ",  $high{$key}, "\n";
    }
}
