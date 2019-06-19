#!/usr/bin/perl
use strict;
use warnings;
use feature "say";
no warnings "recursion";
use Memoize;

memoize('female', 'male');

sub female {
    my $n = shift;
    return 1 if $n == 0;   # base case
    return $n - male (female ($n - 1));
}
sub male {
    my $n = shift;
    return 0 if $n == 0;   #base case
    return $n - female (male ($n - 1));
}
say "Female sequence: ";
say female shift;
