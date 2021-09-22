#! /usr/bin/env perl

use strict;
use warnings;
use Carp;
use Data::Dumper;

my @input = (1, 2, 3, 6, 7, 8, 9);
#my @input = (1, 3, 6, 8, 9);
#my @input = (1, 2, 3, 4);
#my @input = (1);

my @results = ();
my $working = [];
my $lastnum = 0;

foreach my $num (@input) {
    croak "Numbers should be positive integers" unless ($num > 0);
    if ( ($num - $lastnum) > 1 ) {
        push @results, $working;
        $working = [$num];
    } else {
        push @{$working}, $num;
    }
    $lastnum = $num;
}
push @results, $working if scalar(@{$working});

# Acceptable output?
print Dumper(\@results);
