#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <M> <N>
-USAGE-

    exit 0;
}

sub factors {
    my ($n) = @_;

    return grep { $n % $_ == 0; } 1 .. $n / 2;
}

if (scalar @ARGV != 2) {
    usage;
}

my ($M, $N) = @ARGV;

my %f;
map { $f{$_}++; } factors($M);
map { $f{$_}++; } factors($N);

say join q{, }, sort grep { $f{$_} == 2; } keys %f;