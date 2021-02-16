#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S> <T>
  
    <S>    a string.
    <T>    a subsequence to be matched in <S>
-USAGE-
    exit 0;
}

if (scalar @ARGV != 2) {
    usage();
}

my ($S, $T) = @ARGV;

my @patterns = ( $T );
for my $i (0 .. (length $T) - 2) {
    for my $j (1 .. (length $S) - (length $T)) {
        my @t = split //, $T;
        $t[$i] .= ".{$j}";
        my $pattern = join q{}, @t;
        push @patterns, $pattern;
    }
}

my $count = 0;
for my $pattern (@patterns) {
    if ($S =~ /($pattern)/) {
        $count++;
    }
}

say $count;
