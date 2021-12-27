#!/usr/bin/perl
use 5.020;
use warnings;
use threads;
use Time::HiRes qw / usleep /;

sub work {
    my ($arg) = @_;

    usleep $arg * 10_000;
    say $arg;
}

my @threads = map { threads->create(\&work, $_); } @ARGV; 

foreach (@threads) {
    $_->join;
}
