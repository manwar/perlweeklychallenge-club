#!/usr/bin/env perl6
use v6;

# run <script> <numerator> <denominator>

sub maxExp($p,$n) {    
    ($n % $p) ?? (0) !! (1+maxExp($p, $n div $p))
}

sub ordExp($n,$p) {
    my ($ord,$base)=(1,$n mod $p);
    while ($base-1 % $p) {
	$ord++;
	$base = ($base*$n) % $p;
    }
    return $ord;
}

sub when10copr($num,$den) {
    my $int = $num div $den;
    my $digs = ordExp(10,$den);
    my $fract = (($num % $den) * (10**$digs-1)) div $den;
    return $int, '0' x ($digs - $fract.Str.chars) ~ $fract.Str;
}

sub fractPart($num,$den where $num < $den) {
    my $exp2 = maxExp(2,$den);
    my $exp5 = maxExp(5,$den);
    my $newNum = ($exp2 >= $exp5) ?? (5**($exp2-$exp5) * $num) !! (2**($exp5-$exp2) * $num);
    my @copr = when10copr($newNum, $den div (2**$exp2 * 5**$exp5));
    my $nonRep = (@copr.[0] || max($exp2,$exp5)) ?? ('0' x (max($exp2,$exp5) - @copr.[0].Str.chars) ~ @copr.[0].Str) !! ("");
    my $rep = (@copr.[1] ne "0") ?? (qq|({@copr.[1]})|) !! ("");
    return $nonRep ~ $rep;
}

my ($num,$den) = @*ARGS.map(*.Int);
say ($num div $den).Str ~ "." ~ fractPart($num % $den,$den);
