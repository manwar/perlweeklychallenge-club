#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>
  
    <N>    positive integer
-USAGE-
    exit 0;
}

my $N = shift // usage();
if ($N < 1) {
    usage();
}

my $total = 0;
map { $total += sprintf("%b", $_) =~ tr/1/1/; } 1 .. $N;

say "$total % 1000000007 = $total";
