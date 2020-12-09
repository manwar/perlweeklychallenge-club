#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

{
    my ( $sequence ) = @ARGV;
    die 'need dna sequence' unless $sequence;
    my %complements = ( T => 'A', G => 'C' );
    %complements = ( %complements, reverse %complements );

    say 'Nucleiobase count: ' . length( $sequence );
    say 'Complementary sequence: ' . join( '', map { $complements{$_} } split( '', $sequence ) );
}
