#!/usr/bin/perl
use 5.030;
use warnings;

my @nums = @ARGV;

my $comp = ($nums[1] >= $nums[0]) 
    ? sub { $_[0] >= $_[1] }
    : sub { $_[0] <= $_[1] };
my $result = 1;

for my $i (2 .. scalar @nums - 1) {
    unless (&$comp($nums[$i], $nums[$i - 1])) {
        $result = 0;
        last;
    }
}

say $result;