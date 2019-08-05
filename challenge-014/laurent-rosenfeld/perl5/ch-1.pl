#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

my $max = shift;
my @a = (0);
for my $n (0..$max - 1) {
    my $result = 0;
    for my $m (reverse 0..$n-1){
        $result = $n - $m and last if $a[$m] == $a[$n];
    }
    push @a, $result;
}
say "@a";

