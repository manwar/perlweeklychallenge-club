#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <string1> <string2>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub occ($ar1, $ar2) {
    (scalar @{$ar2} == 0) && return 1;
    (scalar @{$ar1} == 0) && return 0;
    
    my @short_ar2=$ar2->@[1..scalar @{$ar2}-1];
    my $sum=0;
    my @arrs =
	map {my @a = $ar1->@[$_+1..scalar @{$ar1}-1]; \@a}
    grep {$ar1->[$_] eq $ar2->[0]}
    keys(@{$ar1});

    for (@arrs) {
	$sum += occ($_,\@short_ar2);
    }
    return $sum;    
}

my ($ar1,$ar2) = map {my @a = split(//,$_); \@a} @ARGV[0,1];

say occ($ar1,$ar2);
