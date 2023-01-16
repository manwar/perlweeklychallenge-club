#!/usr/bin/perl
use 5.030;
use warnings;

my @list = @ARGV;
my @zeros;
my @numbers;

for my $i (@list) {
    if ($i == 0) {
        push @zeros, $i;
    } else {
        push @numbers, $i;
    }
}

push @numbers, @zeros;
say q{(}, (join q{, }, @numbers), q{)};
