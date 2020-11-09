#!/usr/bin/perl
use 5.020;
use warnings;

my $num = shift;
my $sign = 0;

if ($num < 0) {
    $sign = 1;
    $num = abs($num);
}

if ($num > 2_147_483_647) {
    say '0';
} else {
    my $reversed = 0; 

    while ($num > 0) {
        $reversed = $reversed * 10 + $num % 10; 
        $num = int ($num / 10); 
    }

    say $sign ? q{-} : q{}, $reversed;
}