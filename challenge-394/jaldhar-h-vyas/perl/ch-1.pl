#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my @characters = split //, $str;

my @uppers;
for my $pos (keys @characters) {
    if ($characters[$pos] =~ /[A-Z]/) {
        push @uppers, $pos;
    }
}

my @swaps;

for my $offset (0, 1) {
    my $swap = 0;
    my $i = 0;

    for my $pos (keys @characters) {
        if ($pos % 2 == $offset) {
            $swap += abs($uppers[$i] - $pos);
            $i++;
        }
    }

    push @swaps, $swap;
}

say 0+($swaps[0] < $swaps[1]) ? $swaps[0] : $swaps[1];
