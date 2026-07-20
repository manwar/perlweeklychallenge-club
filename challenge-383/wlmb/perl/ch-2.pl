#!/usr/bin/env perl
# Perl weekly challenge 383
# Task 2:  Nearest RGB
#
# See https://wlmb.github.io/2026/07/20/PWC383/#task-2-nearest-rgb
use v5.36;
use feature qw(try);
use List::Util qw(first);

die <<~"FIN" unless @ARGV;
    Usage: $0 C0 C1...
    to obtain the nearest RGB safe color corresponding to
    the color Cn, expressed as an hexadecimal number preceeded
    by a hash mark.
    FIN

my @safe = qw(00 33 66 99 CC FF);
my @boundaries = map{ hex($_) + 25} @safe;
for(@ARGV){
    try{
        die "Expected a hash followed by 6 hex digits: $_" unless /^\#[[:xdigit:]]{6}$/;
        say "$_ -> ",
        join "", "\#",
        map{
            my $value = hex $_;
            $safe[
                first{$value <= $boundaries[$_]} 0..@boundaries-1
            ]
        }
        s/\#//r    # remove leading hash
            =~/(..)/g  # separate in pairs of digits
    }
    catch($e){warn $e;}
}
