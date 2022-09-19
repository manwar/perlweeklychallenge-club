#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use List::Util qw{ sum0 };

my @happy;
while ( scalar @happy < 8 ) {
    state $c = 0;
    $c++;
    push @happy, $c if is_happy($c);
}
say join ", ", @happy;
exit;

sub is_happy( $n ) {
    my $m = $n;
    my %done;
    while ( !$done{$m} ) {
        $done{$m}++;
        $m = sum0 map { $_**2 } split //, $m;
    }
    return $m == 1 ? 1 : 0;
}
