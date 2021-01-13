#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {

    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S>

    <S>    a string
-USAGE-

    exit 0;
}

my $S = shift // usage();

my @output;

for my $i (1 .. length $S) {
    my $slice = substr $S, 0, $i;
    my $fnr = '#';

    for my $c (split //, $slice) {
        my @matches = ($slice =~ /$c/g);
        if (scalar @matches == 1) {
            $fnr = $c;
        }
    }

    push @output, $fnr;
}

say join q{}, @output;