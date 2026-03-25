#!/usr/bin/env perl

# Perl Weekly Challenge 366 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-366/

use Modern::Perl;

@ARGV==1 or die "usage: $0 hh:mm\n";
say count_minutes(shift);

sub count_minutes {
    my ($t) = @_;
    my ($h1, $h2, $colon, $m1, $m2) = split //, $t;

    my $hours =
        ($h1 eq '?' && $h2 eq '?') ? 24 :
        ($h1 eq '?') ? (
            ($h2 <= 9 ? 1 : 0) +      # h1=0
            ($h2 <= 9 ? 1 : 0) +      # h1=1
            ($h2 <= 3 ? 1 : 0)        # h1=2
        ) :
        ($h2 eq '?') ? (
            $h1 =~ /^[01]$/ ? 10 : 4
        ) :
        (($h1.$h2) <= 23 ? 1 : 0);

    my $minutes =
        ($m1 eq '?' ? 6 : 1) *
        ($m2 eq '?' ? 10 : 1);

    return $hours * $minutes;
}
