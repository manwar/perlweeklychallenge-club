#!/usr/bin/perl
use 5.020;
use warnings;

my ($input) = @ARGV;

my @levels = @{ eval $input };
my $count = 0;
my $i = 0;

for my $level (@levels) {
    if ($level->[$i] < ($level->[$i + 1] // 'inf')) {
        $count += $level->[$i];
    } else {
        $count += $level->[$i + 1];
        $i = $i + 1;
    }
}

say $count;