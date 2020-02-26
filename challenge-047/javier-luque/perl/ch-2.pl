#!/usr/bin/perl
# test: perl ch-2.pl
use strict;
use warnings;
use feature qw /say/;

my $n = 100;
my $p = 0;

while ($p < 20) {
    $n =~ /^(\d)\d*(\d)$/;
    my $g_divisor = $1 . $2;

    if ($n % $g_divisor == 0){
        $p++;
        say $n . ' / ' . $g_divisor . ' = ' .
            ($n / $g_divisor);
    }

    $n++;
}
