#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <S> <P>
  
    <S>    a string.
    <P>    a pattern.
-USAGE-
    exit 0;
}

if (scalar @ARGV != 2) {
    usage();
}

my ($S, $P) = @ARGV;

$P =~ s/\*/.*/g;
$P =~ s/\?/./g;
$S =~ /($P)/;

say q{}, (defined $1 && $S eq $1) ? 1 : 0;