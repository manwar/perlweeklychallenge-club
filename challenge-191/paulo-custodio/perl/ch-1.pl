#!/usr/bin/env perl

# Perl Weekly Challenge 191 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-191/

use Modern::Perl;
use List::Util 'max', 'all';

sub twice_largest {
    my(@n)=@_;
    my $max=max(@n);
    my @remain=grep {$_!=$max} @n;
    my $result=all {$_*2<=$max} @remain;
    return $result ? 1 : -1;
}

say twice_largest(@ARGV);
