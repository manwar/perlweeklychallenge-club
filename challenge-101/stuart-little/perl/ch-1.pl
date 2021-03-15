#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <space-separated array entries>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use List::AllUtils qw(min_by);

sub rtcc($m) {
    my @res;
    for my $ix (0..scalar @{$m->[0]}-1) {
	my @col = map {$_->[$ix]} @{$m};
	push @res, (\@col,);
    }
    return [reverse @res];
}

sub pck($rows,$cols,$a) {
    $rows == 1 && return [$a,];
    $cols == 1 && return [map {[$_,]} reverse @{$a}];
    my $rot = rtcc(pck($cols,$rows-1,[$a->@[$cols..scalar @{$a}-1]]));    
    return [@$rot,[$a->@[0..$cols-1]]];
}

my $els = scalar @ARGV;
my $rows = min_by { abs($_ - $els/$_) } grep {$els % $_ == 0} (1..int($els/2));
my $cols = int($els/$rows);

for (@{pck($rows,$cols,[map {sprintf("%5s", $_)} @ARGV])}) {
    say "@$_";
}

