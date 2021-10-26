#!/usr/bin/env perl
# Perl weekly challenge 135
# Task 1: Middle 3-digits
#
# See https://wlmb.github.io/2021/10/20/PWC135/#task-1-middle-3-digits
use v5.12;
use warnings;
my @even_odd=qw(even odd);
say "Usage: ./ch-1.pl howmany number [number] ..." and exit unless @ARGV>1;
my $how_many= shift @ARGV;
my $parity=$how_many%2; # Desire an even or an odd number of digits?
foreach my $input(@ARGV){
    (my $digits=$input)=~s/^[+-]//; # Remove leading sign
    my $length=length $digits;
    my $begin=($length-$how_many)/2; # initial position
    my $output=
	$digits!~/^\d+$/        ? "Expected only digits"
	:$length%2!=$parity? "Expected an $even_odd[$parity] number of digits"
	:$length<$how_many ? "Expected more than $how_many digits"
	:substr($digits, $begin, $how_many). " (middle $how_many digits)";
    say "Input: $input\nOutput: $output";
}
