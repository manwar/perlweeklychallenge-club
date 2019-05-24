#!/usr/bin/perl -w
use strict;
use feature 'say';
use List::Util qw/reduce/;

sub center {
    my $len = length reduce { length $a > length $b ? $a : $b } @_;
    return map { $^A=''; formline '@'.'|' x $len, $_; $^A } @_;
}

map { say } center('This', 'is', 'a test of the', 'center function');
