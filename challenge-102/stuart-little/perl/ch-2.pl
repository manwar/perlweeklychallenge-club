#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <number>

use feature qw(signatures);
no warnings qw(experimental::signatures);

sub hshCount($n) {
    $n == 0 && return "";
    $n == 1 && return "#";
    my $stub = $n . "#";
    return hshCount($n - length($stub)) . $stub;
}

say hshCount($ARGV[0]);
