#!/usr/bin/perl
use 5.030;
use warnings;

my ($count, @numbers) = @ARGV;
my $replaced = 0;

for my $i (0 .. scalar @numbers - 1) {
    if (
        $numbers[$i] == 0 &&
        ($i == 0 || $numbers[$i - 1] == 0) &&
        ($i == scalar @numbers - 1 || $numbers[$i + 1] == 0)
    ) {
        $numbers[$i] = 1;
        $replaced++;
    }

    if ($replaced == $count) {
        say 1;
        exit;
    }
}

say 0;
