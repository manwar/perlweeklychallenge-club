#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars- /;

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<numbers> ...]
-USAGE-

    exit(0);
}

 if (!scalar @ARGV) {
    usage();
 }

my @numbers = sort @ARGV;
my @wave;

my $mid = (scalar @numbers) / 2;
my $end = (scalar @numbers) - 1;

for my $i (0 .. $mid - 1) {
    push @wave, $numbers[$end--];
    push @wave, $numbers[$i];
}
if (scalar @numbers % 2) {
    push @wave, $numbers[$mid];
}

say join q{,}, @wave;

