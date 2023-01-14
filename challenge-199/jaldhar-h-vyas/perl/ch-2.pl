#!/usr/bin/perl
use 5.030;
use warnings;
use English;
use Getopt::Long;

sub usage() {
    say <<"-USAGE-";
 Usage:
  $PROGRAM_NAME [-x[=Int]] [-y[=Int]] [-z[=Int]] [<array> ...]
-USAGE-
    exit(0);
}

my @goodtriplets;
my ($x, $y, $z);
my @array;

GetOptions("x=i" => \$x, "y=i" => \$y, "z=i" => \$z, '<>' => sub { push @array, shift; });
for ($x, $y, $z) {
    defined($_) || usage()
};
scalar @array || usage();

for my $i (0 .. scalar @array - 1) {
    for my $j ($i + 1 .. scalar @array - 1) {
        for my $k ($j + 1 .. scalar @array - 1) {
            if ((abs($array[$i] - $array[$j]) <= $x) &&
               (abs($array[$j] - $array[$k]) <= $y) &&
               (abs($array[$i] - $array[$k]) <= $z)) {
                    push @goodtriplets, [$i, $j, $k];
            }
        }
    }
}

say scalar @goodtriplets;
