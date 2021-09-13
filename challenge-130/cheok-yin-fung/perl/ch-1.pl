#!/usr/bin/perl
# The Weekly Challenge 130
# Task 1 Odd Number
# Usage: $ ch-1.pl @N
use constant BIGN => 1024;

use v5.12.0;
use warnings;
use Test::More tests => 2;

my @N = @ARGV;
@N = (2, 5, 4, 4, 5, 5, 2) if !defined($ARGV[0]);


say "@{oddities(@N)}";
say the_only_odd(@N);

sub the_only_odd {
    my $s = "";
    for my $d (@_) {
        my $md = index((scalar reverse $s), (scalar reverse "- $d "));
        my $pd = index((scalar reverse $s), (scalar reverse "+ $d "));
        $md = BIGN if $md == -1 && $pd >= 0;
        $pd = BIGN if $md == -1 && $pd == -1;
        $s .= $md < $pd ? "+ $d " : "- $d ";
    }
    return eval $s;
}


sub oddities {
    # return all the numbers appear odd number of times
    # inspired by Andrezgz's Week 127 solution after reading 
    # https://theweeklychallenge.org/blog/review-challenge-127/#PWC127TASK1
    my @ans;
    my %ap;
    for (@_) {
        $ap{$_}++ && ($ap{$_} *= -1);
    }
    @ans = grep {$ap{$_} > 0} keys %ap;
    return [@ans];
}


ok ${oddities(1, 2, 3, 4, 3, 2, 1, 4, 4)}[0] == 4, 
   "Example 2 using subroutine oddities";
ok the_only_odd(1, 2, 3, 4, 3, 2, 1, 4, 4) == 4, 
   "Example 2 using subroutine the_only_odd";
