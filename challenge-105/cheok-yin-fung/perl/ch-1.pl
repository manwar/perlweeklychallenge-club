#!/usr/bin/perl 
# The Weekly Challenge 105
# Task 1: Nth Root
# Usage: ch-1.pl $N $k

# $N positive integer, $k positive number
# Accuracy up to 2 decimal places

use strict;
use warnings;

my $pow = 1;
my $N = int $ARGV[0];
my $k = $ARGV[1];

print "WARN: Recommend to take the result from Newton's method if two methods dispute\n";
print "WARN: N is large; probably dispute between two methods \n"
    if $N > 9;         # parameter chosen by testing
print "WARN: N is too large; probably inaccurate result(s) \n" 
    if $N > 100;
print "WARN: k is too small against N; probably output errors \n" 
    if $k/$N < 0.05;


sub lazy_root {
# I like math, but being ultralazy, 
# thought of settling with the task by junior school math
    my $puppet_k = $k * (100**$N);
    my $i = 0;

    while ($pow < $puppet_k) {
        $i++;
        $pow = $i**$N;
    }

    if ($pow > $puppet_k) {
        my $pow_smaller = ($i-1)**$N;
        $i = $i-1 if ($pow - $puppet_k) > ($puppet_k - $pow_smaller);
    }

    $i = $i/100.0;

    if ($pow == $puppet_k) {
        print "$i\n";
    }
    else {
        printf "%.2f\n",$i;
    }
}

sub newton_root {
    my @x;
    $x[0] = $N > 20 ? sqrt($k)/$N : sqrt($k);
    my $dff = 0.0005;  # error terms computable 
                       # but too lazy to check Numerical Analysis textbook
    my $t = 0;
    while ($dff >= 0.0005) {
        $dff = $x[$t]**$N - $k;
        $x[$t+1] = $x[$t] - ( $dff / $x[$t]**($N-1) / $N);
        $t++;
    }

    my $puppet_x = sprintf "%.2f", $x[$t];
    if ($puppet_x**$N==$k) {
        $puppet_x =~ s/\.([0-9])*0$/\.$1/;
        $puppet_x =~ s/\.0$//;
        print "$puppet_x\n";
    }
    else {
        printf "%.2f\n", $x[$t];
    }
}

print "By lazy method:\n";
lazy_root();

print "By Newton's method:\n";
newton_root();
