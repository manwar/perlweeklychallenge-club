#!/usr/bin/perl
use 5.030;
use warnings;
use English qw/ -no_match_vars /;

sub isEsthetic {
    my ($n) = @_;
    my @digits = split //, $n;

    for my $i (0 .. scalar @digits - 2) {
        if (abs($digits[$i] - $digits[$i + 1]) != 1) {
            return undef;
        }
    } 

    return 1;
}

sub usage {
print<<"-USAGE-";
Usage:
  $PROGRAM_NAME <n>
  
    <n>    an integer
-USAGE-
    exit(0);
}

if (scalar @ARGV < 1) {
    usage;
}
my ($n) = @ARGV;

say "$n is ", isEsthetic($n) ? q{} : 'not ', 'an esthetic number';
