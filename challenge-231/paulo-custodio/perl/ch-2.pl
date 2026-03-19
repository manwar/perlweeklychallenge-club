#!/usr/bin/env perl

# Perl Weekly Challenge 231 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/

use Modern::Perl;

say scalar grep {age($_) >= 60} @ARGV;

sub age {
    my($record) = @_;
    my $age = 0+substr($record, 11, 2);
    return $age;
}
