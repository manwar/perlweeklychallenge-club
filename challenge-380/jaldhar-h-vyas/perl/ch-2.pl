#!/usr/bin/perl
use 5.40.1;
use warnings;

my ($str) = @ARGV;
my $reversed = 26;
my %reverse = map { $_ => $reversed-- }'a' .. 'z';
my $result = 0;

for my ($pos, $char) (indexed split //, $str) {
    $result += ($pos + 1) * $reverse{$char};
}

say $result;
