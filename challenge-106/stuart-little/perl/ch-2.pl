#!/usr/bin/perl
use warnings;
use v5.12;

# run <script> <numerator> <denominator>

use feature qw(signatures);
no warnings qw(experimental::signatures);

use bigint;
use List::Util qw(max);

sub maxExp($p,$n) {    
    ($n % $p) ? (0) : (1+maxExp($p, int($n/$p)))
}

sub ordExp($n,$p) {
    my ($ord,$base)=(1,$n % $p);
    while ($base-1 % $p) {
	$ord++;
	$base = ($base*$n) % $p;
    }
    return $ord;
}

sub when10copr($num,$den) {
    my $int = int($num/$den);
    my $digs = ordExp(10,$den);
    my $fract = int ((($num % $den) * (10**$digs-1))/$den);
    return $int, ('0' x ($digs - length($fract))) . $fract;
}

sub fractPart($num,$den) {
    my $exp2 = maxExp(2,$den);
    my $exp5 = maxExp(5,$den);
    my $newNum = ($exp2 >= $exp5) ? (5**($exp2-$exp5) * $num) : (2**($exp5-$exp2) * $num);
    my @copr = when10copr($newNum, int $den/(2**$exp2 * 5**$exp5));
    my $nonRep = ($copr[0] || max($exp2,$exp5)) ? ('0' x (max($exp2,$exp5) - length($copr[0])) . $copr[0]) : ("");
    my $rep = ($copr[1] ne "0") ? (qq|($copr[1])|) : ("");
    return $nonRep . $rep;
}

my ($num,$den) = @ARGV;
say int($num/$den) . "." . fractPart($num % $den,$den);
