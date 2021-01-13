#! /usr/bin/perl
use warnings;
use strict;

#use Data::Dumper;

sub power {
    my ($N) = @_;
    my @r;
    my ($m, $n) = (2, 2);
    while ($m < $N) {
        push @r, "$m^$n" if $m ** $n == $N;
        ++$m, $n = 2 if $m ** ++$n > $N;
    }
    return @r
}

use Test::More tests => 3;

is_deeply [power(9)], ['3^2'];
is power(45), 0;
is_deeply [power(64)], [qw[ 2^6 4^3 8^2 ]];
