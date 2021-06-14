#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>
  
    <N>    integer greater than 9
-USAGE-
    exit 0;
}

my ($N) = shift // usage;

if ($N < 10) {
    usage;
}

my @digits = map { $_ * $_} split //, $N;
my $total = 0;
for my $digit (@digits) {
    $total += $digit;
}

say sqrt($total) =~ / ^ [[:digit:]]+ $ /x ? 1 : 0;
