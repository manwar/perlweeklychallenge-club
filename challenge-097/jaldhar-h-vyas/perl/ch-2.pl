#!/usr/bin/perl
use 5.020;
use warnings;
use English qw/ -no_match_vars /;

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME <S> <N>
  
    <S>    a binary string
    <N>    size of substrings
-USAGE-
    exit 0;
}


if (scalar @ARGV != 2) {
    usage;
}

my ($B, $S) = @ARGV;

my @substrings = map { '0b' . $_; } unpack("(A$S)*", $B);
my $template = shift @substrings;
my $flips = 0;

for my $string (@substrings) {
    $flips += sprintf('%b', oct($template) ^ oct($string)) =~ tr/1/1/;
}

say $flips;