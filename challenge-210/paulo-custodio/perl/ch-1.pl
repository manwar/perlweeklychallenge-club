#!/usr/bin/env perl

# Perl Weekly Challenge 210 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-210/

use Modern::Perl;
use List::Util 'sum';

sub kill_and_win {
    my(@n)=@_;
    return 0 if @n==0;
    # kill one and recurse
    my $max=0;
    for my $i (0..$#n) {
        my $kill=$n[$i];
        my @copy=@n;
        splice(@copy,$i,1);                             # remove kill value
        my $value=$kill+sum(0,grep {$_==$kill+1 || $_==$kill-1} @copy);
        @copy=grep {$_!=$kill+1 && $_!=$kill-1} @copy;  # remove above and below
        $value+=kill_and_win(@copy);
        $max=$value if $max<$value;
    }
    return $max;
}

say kill_and_win(@ARGV);
