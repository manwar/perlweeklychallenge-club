#!/usr/bin/perl
# The Weekly Challenge 157
# Task 2 Brazilian Number
use v5.22.0;
use warnings;

my $N = $ARGV[0] || 10;

my $ans = find($N);
if ($ans) {
    say "$N is a repdigit in base-", $ans, "; therefore it's Brazilian.";
}
else {
    say "$N is not a Brazilian number."
}



sub divisor_pair {
# lazy way to find divisors
    my $num = $_[0];
    my %pair = ();
    for my $a (2..int sqrt $num - 1) {
        $pair{$num/$a} = $a if $num % $a == 0;
    }
    return {%pair};
}



sub proper_divisors_lt_one {
# lazy way to find divisors
    my $num = $_[0];
    my @pd = ();
    my @rev_pd = ();
    for my $i (2..int sqrt $num) {
        if ($num % $i == 0) {
            push @pd, $i;
            unshift @rev_pd, $num/$i;
        }
    }
    return [@pd, @rev_pd];
}



sub monoBrazilian {
    my $num = $_[0];
    my $full = $_[1];
    my @pb = proper_divisors_lt_one($num-1)->@*;
    push @pb, $num-1 if !$full;
    for my $b (@pb) {
        my $r = $num % $b;
        my $_num = $num;
        while ($r == 1 && $_num > 1) {
            $_num = int $_num/$b;
            $r = $_num % $b;
        }
        if ($r == 1 && $_num == 1) {
            return $b;
        }
    }
    return 0;
}



sub find {
    my $n = $_[0];
    die "Incorrect input" if $n <= 3;
    return $n/2-1 if $n % 2 == 0 && $n > 6; # general case for even number
    return 0 if $n == 6;                    # special case

    my %divisor_pair = divisor_pair($n)->%*;
    for my $k (keys %divisor_pair) {
        if (my $base = monoBrazilian($k, 0)) {
            return $base;
        }
    }
    return monoBrazilian($n, 1);
}


use Test::More tests => 8;
# Test data from A125134 and A220570 in OEIS
ok find(15);
ok find(81);
ok find(465);
ok find(999);
ok !find(11);
ok !find(19);
ok !find(281);
ok !find(2027);
