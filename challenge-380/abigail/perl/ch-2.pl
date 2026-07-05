#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

while (my $line = <>) {
    my $sum   = 0;
    my $index = 0;
    foreach my $ch (split // => $line) {
        $index ++;
        if ("a" le $ch le "z") {
            $sum += $index * (ord ("z") - ord ($ch) + 1)
        }
    }
    say $sum
}

__END__
