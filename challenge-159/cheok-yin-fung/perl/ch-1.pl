#!/usr/bin/perl
# The Weekly Challenge 159
# Task 1 Farey Sequence
# Usage: ch-1.pl $N
# https://en.wikipedia.org/wiki/Farey_sequence#Next_term

use v5.22.0;
use warnings;
use POSIX;

my $N = $ARGV[0] if defined($ARGV[0]); 

say farey($N) if defined($ARGV[0]);



sub farey {
    my $n = $_[0];
    die "The parameter should be a positive integer." if $n==0;
    my ($g, $h) = ([0,1], [1, $n]);
    my @terms;
    do {
        push @terms, "".join("/", $g->@*);
        my ($a, $b) = $g->@*;
        my ($c, $d) = $h->@*;
        my ($p, $q) = (
            $c*floor (($n+$b)/$d) - $a, 
            $d*floor(($n+$b)/$d) - $b
        );
        ($g, $h) = ($h, [$p, $q]);
    } while (!($h->[0] == 1 && $h->[1] == 1));
    push @terms, join("/", $g->@*), join("/", $h->@*);
    return join(", ",@terms) . ".";
}



use Test::More tests => 3;
ok(
    "0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1."
    eq farey(5), "Example 1");
ok(
    "0/1, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 2/5, 3/7, 1/2, 4/7, 3/5,"
    . " 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 1/1." eq farey(7), "Example 2");
ok("0/1, 1/4, 1/3, 1/2, 2/3, 3/4, 1/1." eq farey(4), "Example 3");
