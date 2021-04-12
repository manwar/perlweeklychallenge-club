#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl [plain|fetch|compute]
#
#
# Three solutions, depending on the command line argument:
#   1) We just print the first 10 Bell numbers. The simplest solution.
#   2) We fetch the first 10 Bell numbers from the OEIS.
#   3) We calculate the Bell numbers from the Bell triangle.
#

my $COUNT        = 10;

my $TYPE_PLAIN   =  0;
my $TYPE_FETCH   =  1;
my $TYPE_COMPUTE =  2;

my $type = $TYPE_PLAIN;   # Default
   $type = $TYPE_FETCH   if @ARGV && $ARGV [0] eq "fetch";
   $type = $TYPE_COMPUTE if @ARGV && $ARGV [0] eq "compute";


if ($type == $TYPE_PLAIN) {
    say "1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147";
}
elsif ($type == $TYPE_FETCH) {
    use OEIS;
    $, = ", ";
    say oeis (110 => 10)
}
elsif ($type == $TYPE_COMPUTE) {
    my $COUNT = 10;

    #
    # Create Bell triangle (See https://en.wikipedia.org/wiki/Bell_triangle)
    # The Bell numbers (starting from the second one), are on the
    # right diagonal.
    #
    # The Bell triangle is defined as follows:
    #    Bell (0, 0) = 1
    #    Bell (n, 0) = Bell (n - 1, n - 1), k > 0
    #    Bell (n, m) = Bell (n, m - 1) + Bell (n - 1, m - 1), n > 0, m > 0
    #
    my @bell = [1];
    for (my $x = 1; $x < $COUNT - 1; $x ++) {
        $bell [$x] [0] = $bell [$x - 1] [-1];
        for (my $y = 1; $y <= $x; $y ++) {
            $bell [$x] [$y] = $bell [$x] [$y - 1] + $bell [$x - 1] [$y - 1]
        }
    }

    $, = ", ";
    say 1, map {$$_ [-1]} @bell;
}
