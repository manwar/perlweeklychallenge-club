#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(say state);
use Carp;

# Write a script to demonstrate Mutually Recursive methods. Two methods are
# mutually recursive if the first method calls the second and the second calls
# first in turn. Using the mutually recursive methods, generate Hofstadter
# Female and Male sequences.

sub hofstadter_F {
    my $n = shift;
    state %cache = ( 0 => 1 );

    return $cache{$n} if exists $cache{$n};
    return $cache{$n} = $n - hofstadter_M( hofstadter_F( $n - 1 ) );
}

sub hofstadter_M {
    my $n = shift;
    state %cache = ( 0 => 0 );

    return $cache{$n} if exists $cache{$n};
    return $cache{$n} = $n - hofstadter_F( hofstadter_M( $n - 1 ) );
}

my $n = shift or die "Usage: $0 <n>\n";

say "F: ", join( ", ", map { hofstadter_F($_) } ( 0 .. $n ) );
say "M: ", join( ", ", map { hofstadter_M($_) } ( 0 .. $n ) );
