#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use List::Util 'any';

sub main {
    # Turn the set into two arrays
    my ( $set1, $set2 ) = @_;
    my @set1 = ( $set1 =~ /(\d+)/g );
    my @set2 = ( $set2 =~ /(\d+)/g );

    # Turn the first set into a hash
    my %set1 = map { $_, 1 } @set1;

    # See if any values in the second set are in the hash
    my $disjoined = ( any { exists $set1{$_} } @set2 ) ? 0 : 1;
    say $disjoined;
}

main(@ARGV);
