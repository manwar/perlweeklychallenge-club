#!/usr/bin/perl
use strict;
use warnings;

sub is_prime {
    my $n = shift;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    
    return 0 if $n % 2 == 0 || $n % 3 == 0;
    
    my $i = 5;
    while ($i * $i <= $n) {
        return 0 if $n % $i == 0 || $n % ($i + 2) == 0;
        $i += 6;
    }
    return 1;
}

my $count = 0;
my $num = 2;

while ($count < 10) {
    if (is_prime($num) && is_prime($num + 6)) {
        print "($num, ", $num + 6, ")\n";
        $count++;
    }
    $num++;
}

