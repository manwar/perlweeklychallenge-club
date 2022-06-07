#!/usr/bin/perl
# The Weekly Challenge 168
# Task 2 Home Prime 
# Usage: ch-2.pl [integer > 1]
use v5.24.0;
use warnings;
use List::Util qw/reduce/;
use Math::BigInt::GMP;          # [remark]
use Math::BigInt::Pari;         # [remark]
use Math::Prime::Util::GMP qw/is_prime next_prime/;
use bigint try => 'GMP,Pari';   # [remark]
# remark: follow suggestions on POD of Math::Prime::Util


say hp($ARGV[0]) if defined($ARGV[0]);



sub hp {
    my_hp($_[0],0);
}



sub my_hp {
    my $recur_depth = $_[1];

    die "Walk so far but still cannot get result. :(\n" if $recur_depth > 10;
    my $num = $_[0];
    if (is_prime($num) == 2) {
        return $num;
    }

    my @factors = ();
    my $p = 2;
    do {
        if (!($num % $p)) {
            push @factors, $p;
            $num /= $p;
        }
        else {
            $p = next_prime($p);
        }
    } while ($num != 1);
    my $nxt = (reduce { $a . $b } @factors);
    say "  $nxt";
    return my_hp($nxt, ++$recur_depth);
}

use Test::More tests => 5;
# test data from OEIS
ok hp(10) == 773;
ok hp(24) == 331_319;
ok hp(32) == 241_271;
ok hp(45) == 3_411_949;

ok hp(44) == 22815088913;  # this test spends approx 0.5 min (on CY's laptop).

# ok hp(40) == 3314192745739;  # this test spends approx. 2 min.
