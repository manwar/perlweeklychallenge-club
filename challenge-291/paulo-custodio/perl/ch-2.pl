#!/usr/bin/env perl

# Perl Weekly Challenge 291 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-291/

use Modern::Perl;
use List::Util 'sum';

# 1. How many different 5-card hands can be dealt?
my $N = binomial(52, 5);
say "N= ",$N;

# 2. How many different hands of each of the 10 ranks can be dealt?
# high card
my @n;
$n[0] = (binomial(13,5)-10)*(binomial(4,1)**5-4);
say "n0= ",$n[0];

# one pair hand
$n[1] = binomial(13,1)*binomial(4,2)*binomial(12,3)*binomial(4,1)**3;
say "n1= ",$n[1];

# two pair hand
$n[2] = binomial(13,2)*binomial(4,2)**2*binomial(11,1)*binomial(4,1);
say "n2= ",$n[2];

# three of a kind
$n[3] = binomial(13,1)*binomial(4,3)*binomial(12,2)*binomial(4,1)**2;
say "n3= ",$n[3];

# straight hand
$n[4] = binomial(10,1)*(binomial(4,1)**5-4);
say "n4= ",$n[4];

# flush hand
$n[5] = (binomial(13,5)-10)*binomial(4,1);
say "n5= ",$n[5];

# full house hand
$n[6] = binomial(13,1)*binomial(4,3)*binomial(12,1)*binomial(4,2);
say "n6= ",$n[6];

# four of a kind hand
$n[7] = binomial(13,1)*binomial(4,4)*binomial(12,1)*binomial(4,1);
say "n7= ",$n[7];

# straight flush hand
$n[8] = binomial(10,1)*binomial(4,1)-4;
say "n8= ",$n[8];

# royal flush hand
$n[9] = 4;
say "n9= ",$n[9];

# 3. Check the ten numbers you get in step 2 by adding them together
#    and showing that they're equal to the number you get in step 1.
$N == sum(@n) or die;


sub fact {
    my($n) = @_;
    my $p = 1;
    for (2..$n) {
        $p *= $_;
    }
    return $p;
}

sub binomial {
    my($n, $k) = @_;
    return fact($n) / (fact($k) * fact($n - $k));
}
