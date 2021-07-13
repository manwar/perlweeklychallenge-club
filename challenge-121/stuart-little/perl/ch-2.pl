#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <nr of cities>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use Algorithm::Permute qw(permute);
use List::Util qw(sum);

sub mkRMat($n) {
    my @mat = map {my $i = $_; my @row = map {($_ == $i) ? (0) : (int(rand(9))+1)} (1..$n); \@row} (1..$n);
    return \@mat;
}

sub sayMat($m) {
    for (@{$m}) {
	say "@{$_}";
    }
}

sub pathCost($path,$mat) {
    return sum map {$mat->[$path->[$_]]->[$path->[($_+1) % (scalar @{$path})]]} (0..$#$path)
}

my $mat = mkRMat($ARGV[0]);

say "Your matrix:";
sayMat($mat);

my @init=(0..$ARGV[0]-1);
my @sol = @init;
my $cost=pathCost(\@init,$mat);

permute { if ((my $newCost = pathCost(\@init,$mat)) < $cost) {$cost = $newCost; @sol = @init} } @init;

say "Optimal cost: $cost";
say "Optimal path: @sol $sol[0]";
