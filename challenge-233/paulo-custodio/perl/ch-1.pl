#!/usr/bin/env perl

# Perl Weekly Challenge 233 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-233/

use Modern::Perl;

my @words = @ARGV;
my $count = 0;
for my $i (0 .. $#words-1) {
    for my $j ($i+1 .. $#words) {
        $count++ if is_similar($words[$i], $words[$j]);
    }
}
say $count;

sub is_similar {
    my($a, $b) = @_;

    while ($a ne '' && $b ne '') {
        my $ch = substr($a, 0, 1);
        $a =~ s/$ch//gi;
        $b =~ s/$ch//gi;
    }
    return $a eq '' && $b eq '';
}
