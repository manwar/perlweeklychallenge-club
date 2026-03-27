#!/usr/bin/env perl

# Perl Weekly Challenge 192 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-192/

use Modern::Perl;
use List::Util 'sum';

sub equalize_ {
    my($num_moves, @n)=@_;
    return $num_moves if @n<2;

    while (1) {
        return $num_moves if scalar(grep {$n[0]==$n[$_]} 0..$#n)==@n;

        # find biggest difference
        my $max_diff=0; my $max_from=0; my $max_to=0;
        for my $i (0..$#n-1) {
            for my $j ($i+1..$#n) {
                my $diff=abs($n[$i]-$n[$j]);
                if ($diff>$max_diff) {
                    $max_diff=$diff;
                    if ($n[$i]>$n[$j]) {
                        ($max_from,$max_to)=($i,$j);
                    }
                    else {
                        ($max_from,$max_to)=($j,$i);
                    }
                }
            }
        }
        return -1 if $max_diff==0;

        # move
        my $dir=$max_to>$max_from ? 1 : -1;
        $n[$max_from]--; $n[$max_from+$dir]++; $num_moves++;
    }
}

sub equalize {
    my(@n)=@_;
    my $avg=sum(@n)/@n;
    if (int($avg)==$avg) {
        return equalize_(0, @n);
    }
    else {
        return -1;
    }
}

say equalize(@ARGV);
