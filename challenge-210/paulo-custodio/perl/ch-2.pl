#!/usr/bin/env perl

# Perl Weekly Challenge 210 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-210/

use Modern::Perl;

sub find_collision {
    my(@n)=@_;
    for my $i (0..$#n-1) {
        if ($n[$i]>0 && $n[$i+1]<0) {
            return $i;
        }
    }
    return -1;
}

sub number_collision {
    my(@n)=@_;
    my $i;
    while (($i=find_collision(@n))>=0) {
        if (abs($n[$i])==abs($n[$i+1])) {
            splice(@n,$i,2);            # both explode
        }
        elsif (abs($n[$i])>abs($n[$i+1])) {
            splice(@n,$i+1,1);          # right explodes
        }
        elsif (abs($n[$i])<abs($n[$i+1])) {
            splice(@n,$i,1);            # left explodes
        }
        else { die; }
    }
    return @n;
}

@ARGV or die "usage: ch-2.pl nums...\n";
my @n=@ARGV;
@n=number_collision(@n);
say "(",join(", ", @n),")";
