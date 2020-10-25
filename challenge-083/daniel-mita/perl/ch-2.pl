#!/usr/bin/env perl

use strict;
use warnings;
use feature qw<say>;

use List::Util qw<sum>;
use Scalar::Util qw<looks_like_number>;

if ( @ARGV == 0 || grep { !looks_like_number($_) || $_ < 1 } @ARGV ) {
    say 'List of positive numbers required.';
    exit 1;
}

my @combinations;
for ( my $i = 0; $i < @ARGV; $i++ ) {
    for ( my $j = $i; $j < @ARGV; $j++ ) {
        push @combinations, [ @ARGV[ $i .. $j ] ];
    }
}

say scalar(
    @{  [   sort { sum( @{$b} ) <=> sum( @{$a} ) || @{$a} <=> @{$b} }
            grep { sum( @{$_} ) <= sum(@ARGV) / 2 } @combinations
        ]->[0]
    }
);
