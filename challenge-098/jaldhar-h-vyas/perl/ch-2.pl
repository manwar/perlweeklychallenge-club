#!/usr/bin/perl
use 5.020;
use warnings;
use English qw / -no_match_vars /;

sub usage {
    print <<"-USAGE-";
  $PROGRAM_NAME [<N> ...]
  
    [<N> ...]    a series of atleast 2 distinct integers. The last element will be used as a target to search in the previous elements.
-USAGE-
    exit 0;
}

if (scalar @ARGV < 2) {
    usage();
}

my $N = pop @ARGV;
my $pos = scalar @ARGV;

for my $i (0 .. scalar @ARGV - 1) {
    if ($ARGV[$i] >= $N) {
        $pos = $i;
        last;
    }
}

say $pos;