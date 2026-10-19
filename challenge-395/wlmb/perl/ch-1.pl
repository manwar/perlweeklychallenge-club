#!/usr/bin/env perl
# Perl weekly challenge 395
# Task 1:  Complex Number
#
# See https://wlmb.github.io/2026/10/18/PWC395/#task-1-complex-number
use v5.36;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 X0 Y0 X1 Y1...
    to multiply the complex numbers Xn and Yn.
    FIN
for my($x, $y)(@ARGV){
    try{
	my ($xc, $yc) = map {s2c($_)} $x, $y;
	my $rc=mult($xc, $yc);
	say "$x $y -> ", c2s($rc);
    }
    catch($e){warn $e;}
}
sub s2c($n){
    my $num='[+-]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?';
    my ($re, $imn, $imp)=$n=~/^($num)\+(?:\((\-$num)\)|($num))i$/;
    my $im=$imn//$imp;
    die "Bad format: $n" unless defined $re and defined $im;
    return [$re, $im];
}
sub mult($x, $y){
    return [$x->[0]*$y->[0]-$x->[1]*$y->[1], $x->[0]*$y->[1]+$x->[1]*$y->[0]];
}
sub c2s($n){
    return $n->[1]>=0 ? "$n->[0]+$n->[1]i"
                      : "$n->[0]+($n->[1])i";
}
