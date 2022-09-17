#!/usr/bin/perl
use List::Util qw(max uniq); use v5.10; use warnings; use strict;

my @paths = map s/\n//r, <>;

say compath(@paths);    

sub compath {
    my $l = max(map length,@_)-1;
    uniq(@_)==1 ? pop : compath( map s/(.{$l}).$/$1/r, @_ )
}
