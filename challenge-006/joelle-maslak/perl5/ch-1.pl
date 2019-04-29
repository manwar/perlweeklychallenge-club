#!/usr/bin/env perl
use v5.26;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use autodie;

# To call this application:
#
# perl ch-1.pl <numbers>
#
# Numbers should be space seperated.
#

my $run;
my @runs;

for my $num ( sort( { $a <=> $b } @ARGV ) ) {
    if ( !defined $run ) {
        $run = [ $num, $num ];
    } else {
        if ( $run->[1] == $num - 1 ) {
            $run->[1] = $num;
        } else {
            push @runs, $run;
            $run = [ $num, $num ];
        }
    }
}
push @runs, $run if defined $run;

say join( ",", map( { ( $_->[0] != $_->[1] ) ? join( '-', @$_ ) : $_->[0] } @runs ) );

