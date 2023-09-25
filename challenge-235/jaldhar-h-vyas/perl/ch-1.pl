#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ smartmatch /;

my $increasing = undef;

for my $i (0 .. scalar @ARGV - 1) {
    my @copy = @ARGV;
    splice @copy, $i, 1;

    if (\@copy ~~ [sort @copy]) {
        $increasing = 1;
        last;
    }
}

say $increasing ? 'true' : 'false';
