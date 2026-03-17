#!/usr/bin/env perl

# Perl Weekly Challenge 313 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-313/

use Modern::Perl;

say is_typed(@ARGV) ? "true" : "false";

sub is_typed {
    my($string, $got) = @_;
    (my $match = $string) =~ s/(.)/$1+/g;
    return $got =~ /$match/;
}
