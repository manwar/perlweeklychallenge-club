#!/usr/bin/env perl

# Perl Weekly Challenge 191 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-191/

use Modern::Perl;

sub cute_list_ {
    my($count, $prefix, $pending)=@_;
    if (@$pending==0) {
        $$count++;
    }
    else {
        my @prefix=@$prefix;
        my $div=scalar(@prefix)+1;
        for my $i (0..$#$pending) {
            my $n=$pending->[$i];
            if ($n%$div==0 || $div%$n==0) {
                my @copy=@$pending;
                splice(@copy,$i,1);
                cute_list_($count,[@prefix,$n],\@copy);
            }
        }
    }
}

sub cute_list {
    my($n)=@_;
    my $count=0;
    cute_list_(\$count,[],[1..$n]);
    return $count;
}

say cute_list(shift);
