#!/usr/bin/env perl

# Perl Weekly Challenge 231 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-231/

use Modern::Perl;
use List::Util 'min', 'max';

my @r = min_max(@ARGV);
say @r==0 ? "-1" : "(".join(", ", @r).")";

sub min_max {
    my(@n) = @_;
    my $min = min(@n);
    my $max = max(@n);
    my @ret = grep {$_ != $min && $_ != $max} @n;
    return @ret;
}
