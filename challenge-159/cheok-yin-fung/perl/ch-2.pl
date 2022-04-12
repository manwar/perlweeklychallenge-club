#!/usr/bin/perl
# The Weekly Challenge 159
# Task 2 Moebius Function
# Usage: ch-2.pl $N
use v5.22.0;
use warnings;
use Math::Complex;
use List::Util qw/any/;
use POSIX;

use constant PI => 2*acos(0);


my $N =  $ARGV[0] if defined($ARGV[0]);
say "mu($N) = ", mo($N) if defined($ARGV[0]);


sub irn {
    my $i = $_[0];
    my $n = $_[1];
    return Math::Complex->make(
        cos 2*PI*$i/$n, sin 2*PI*$i/$n
    );
}



sub mo {
    my $n = $_[0];
    return 1 if $n == 1;
    return -1 if $n == 2;
    my $sum = irn(1, $n);
    for my $i (2..$n-1) {
        next if any { ($i*$_) % $n == 0} (2..$n-1);
        $sum += irn($i, $n); 
    }
    # say "# intermediate sum: ", Re($sum), "\n\n";
    return floor(Re($sum)+0.5);
}



use Test::More tests => 18;
ok mo(2) == -1, "test for 2";
ok mo(5) == -1, "Example 1";
ok mo(10) == 1, "Example 2";
ok mo(20) == 0, "Example 3";
ok mo(22) == 1, "test for 22";
ok mo(41) == -1, "test for 41";
ok mo(42) == -1, "test for 42";
ok mo(43) == -1, "test for 43";
ok mo(44) == 0, "test for 44";
ok mo(45) == 0, "test for 44";
ok mo(46) == 1, "test for 46";
ok mo(47) == -1, "test for 47";
ok mo(48) == 0, "test for 48";
ok mo(49) == 0, "test for 49";
ok mo(50) == 0, "test for 50";
ok mo(3276) == 0, "test for 3276";
ok mo(3277) == 1, "test for 3277";
ok mo(3278) == -1, "test for 3278";
