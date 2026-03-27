#!/usr/bin/env perl

# Perl Weekly Challenge 189 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-189/

use Modern::Perl;

sub degree {
    my(@n)=@_;
    my @freq; $freq[$_]++ for @n;
    @freq=sort {$b<=>$a} @freq;
    return $freq[0];
}

sub smallest_slice {
    my(@n)=@_;
    my $degree=degree(@n);
    my @smallest_slice=@n;
    for my $i (0..$#n-1) {
        for my $j ($i+1..$#n) {
            my @slice=@n[$i..$j];
            if (degree(@slice)==$degree && @slice<@smallest_slice) {
                @smallest_slice=@slice;
            }
        }
    }
    return @smallest_slice;
}

@ARGV>=2 or die "usage: ch-2.pl nums...\n";
say "(",join(", ", smallest_slice(@ARGV)),")";
