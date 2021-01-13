#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {

    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME [<A> ...]

    [<A> ...]    list of integers
-USAGE-

    exit 0;
}

sub min {
    my @A = @{ $_[0] };
    my $least = $A[0];

    for my $i (1 .. scalar @A - 1) {
        if ($A[$i] < $least) {
            $least = $A[$i];
        }
    }

    return $least;
}

my @A = @ARGV;

if (!scalar @A) {
    usage();
}

my @output;

for my $i (0 .. scalar @A - 1) {
    my $lowest = min([ grep { $_ < $A[$i]; } @A[0 .. $i - 1] ]);
    push @output, $lowest // 0;
}

say join q{ }, @output;
