#!/usr/bin/env raku

# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-069/

# Comments: https://andrewshitov.com/2020/07/13/raku-challenge-week-69-issue-2/

my @bits of int;
@bits.push(0);

for ^7 -> $n {
    my $size = @bits.elems;
    print "S{$n+2} = ";
    @bits.push(0);
    @bits.push(@bits[$size - $_] ?? 0 !! 1) for 1 .. $size;

    .print for @bits;
    ''.say;
}
