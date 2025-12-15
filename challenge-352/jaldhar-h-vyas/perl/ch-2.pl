#!/usr/bin/perl
use 5.038;
use warnings;

my @nums = @ARGV;
my @results;
my $str = "0b";

for my $num (@nums) {
    $str .= $num;
    push @results, oct($str) % 5 == 0;
}

say q{(}, (join q{, }, map { $_ ? 'true' : 'false' } @results), q{)};
