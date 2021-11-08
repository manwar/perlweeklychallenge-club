#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub bin2dec {
    my $bin = shift;
    my $sum = 0;
    for my $i (split //, $bin) {
        $sum = $sum * 2 + $i;
    }
    return $sum;
}

for my $test (101, 154, 33, 18) {
    my $b2 = sprintf "%08b", $test;
    $b2 =~ s/(\d)(\d)/$2$1/g;
    say "$test: ", bin2dec $b2;;
}
