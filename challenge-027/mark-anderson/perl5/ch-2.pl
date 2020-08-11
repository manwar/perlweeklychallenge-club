#!/usr/bin/env perl

package XHistory;
require Tie::Scalar;
@ISA = 'Tie::StdScalar';
use Modern::Perl '2018';
use feature qw(signatures);
no warnings qw(experimental::signatures);

my @history;

sub STORE($self, $value) {
    push @history, $value;
}

sub FETCH($self) {
    $history[-1];
}

tie my $x, 'XHistory';

$x = 10;
$x = 20;
$x -= 5;
$x += 1;
$x *= 3;
$x = $x / 2;

say "@history";
