#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <N>
  
    <N>    number to factorialize and count trailing 0's (1 - 10)
-USAGE-
    exit 0;
}

my $N = shift // usage();
if ($N < 1 || $N > 10) {
    usage();
}
my $factorial = 1;

for my $i (2 .. $N) {
    $factorial *= $i;
}

$factorial =~ /(0+)$/;
say length $1 // 0;