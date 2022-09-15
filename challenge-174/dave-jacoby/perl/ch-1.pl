#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @disarium;
my $iter = make_iterator(1);
my $c = 1;
while ( my $i = $iter->() ) {
    $i--;
    next unless is_disarium($i);
    say qq{ $c. $i};
    $c++;
    push @disarium, $i;
    last if scalar @disarium >= 19;
}

exit;

sub is_disarium ( $n ) {
    my @n = split //, $n;
    my $o = 0;
    for my $i ( 1 .. scalar @n ) {
        $o += $n[ $i - 1 ]**$i;
    }
    return $n == $o ? 1 : 0;
}

sub make_iterator($n) {
    return sub {
        state $v = $n;
        return $v++;
    }
}

