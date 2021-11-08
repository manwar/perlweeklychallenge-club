#!/usr/bin/env perl
use warnings;
use v5.12;

# run <script> <space-separated numbers>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use Data::PowerSet qw(powerset);
use List::AllUtils qw(sum0 min_by);
use Set::Scalar;

sub splt($ar) {
    my $powerSet = powerset({min => int(scalar @{$ar}/2), max => int(scalar @{$ar}/2)}, @{$ar});
    my $set = Set::Scalar->new(@{$ar});
    return min_by {abs((sum0 @{$_->[0]}) - (sum0 @{$_->[1]}))} map {my @diff = $set->difference(Set::Scalar->new(@{$_}))->members; [$_, \@diff]} @{$powerSet};
}

my $splt = splt(\@ARGV);
say "@{$splt->[0]}";
say "@{$splt->[1]}";
