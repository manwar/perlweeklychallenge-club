#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub find_diff {
    my ($diff, @array) = @_;
    for my $i (0..$#array - 1) {
        for my $j ($i +1.. $#array) {
            say "Indices $j and $i (values: $array[$j], $array[$i])"
                if $array[$j] - $array[$i] == $diff;
        }
    }
}
my $k = shift // 2;
my @N = @ARGV;
@N = (2, 7, 9) unless @N;
find_diff $k, @N;
