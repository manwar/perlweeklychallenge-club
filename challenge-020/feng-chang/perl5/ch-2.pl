#!/bin/env perl

use Modern::Perl;
use integer;

my $i = 0;
my %sods;
my $cnt = 0;

while (1) {
    $sods{ $i } = sod($i) unless defined $sods{ $i };
    my $v = $sods{ $i };
    
    if ($v > $i) {
        $sods{ $v } = sod($v) unless defined $sods{ $v };
        if ($i == $sods{ $v }) {
            say "$i $v";
            last if ++$cnt == 5;
        }
    }

    ++$i;
}

# sum of proper divisors
sub sod {
    my $n = shift;

    my $sum = 0;
    my @a = (1) x ($n/2 + 1);

    for (my $i = 1; $i < $n/2 + 1; ++$i) {
        next unless $a[$i];

        if ($n % $i) {
            my $j = $i;
            while ($j <= $n/2 + 1) {
                $a[$j] = 0;
                $j += $i;
            }
        } else {
            $sum += $i;
        }
    }

    return $sum;
}
