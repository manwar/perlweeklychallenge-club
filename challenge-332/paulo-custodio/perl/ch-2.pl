#!/usr/bin/env perl

# Perl Weekly Challenge 332 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-332/

use Modern::Perl;

@ARGV==1 or die "usage: $0 word\n";
say odd_letters($ARGV[0]) ? "true" : "false";

sub odd_letters {
    my($str) = @_;
    my %str; $str{$_}++ for split //, $str;
    for (values %str) {
        return 0 if $_ % 2 == 0;
    }
    return 1;
}
