#!/usr/bin/env perl

# Perl Weekly Challenge 250 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-250/

use Modern::Perl;
use List::Util 'max';

say max(map {str_value($_)} @ARGV);

sub str_value {
    my($str) = @_;
    if ($str =~ /^\d+$/) {
        return 0+$str;
    }
    else {
        return length($str);
    }
}
