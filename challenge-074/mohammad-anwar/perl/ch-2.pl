#!/usr/bin/perl

#
# Perl Weekly Challenge - 074
#
# Task #2: FNR Character
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-074
#

use strict;
use warnings;

my $S = $ARGV[0] || 'ababc';

print join "\n", (join ' => ', $S, fnr_character($S)), '';

sub fnr_character {
    my ($string) = @_;

    my @fnr = ();
    foreach my $i (0 .. length($string) - 1) {
        my $s = substr($string, 0, $i + 1);
        if (length($s) == 1) {
            push @fnr, $s;
        }
        else {
            my $found = 0;
            my %count = ();

            $count{$_}++ for split //, $s;
            foreach (split //, reverse $s) {
                if ($count{$_} == 1) {
                    push @fnr, $_;
                    $found = 1;
                    last;
                }
            }
            push @fnr, '#' unless ($found);
        }
    }

    return join '',@fnr;
}
