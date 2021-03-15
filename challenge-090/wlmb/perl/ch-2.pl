#!/usr/bin/env perl
# Multiply two numbers using the Ethiopian Multiplication
# See https://wlmb.github.io/2020/12/07/PWC90/#task-2-ethiopian-multiplication
use strict;
use warnings;
use v5.10;
use integer;
use List::Util qw(all);

# receive the two numbers in @ARGV
die 'Usage: ./ch2.pl number1 number2' unless @ARGV==2;
my ($x, $y)= @ARGV; #
die 'Expected two non-negative integers'   # check they are postitive integers
    unless all {int($_) eq $_ && $_>=0} ($x, $y); #Use eq to avoid implicit int conversion

my $expected_result=$x*$y;
my $result=0;
my $result_string="$x x $y = ";
my $operator="";

while($x){
    if($x&1){  # $x is odd, add $y to result
	print "->"; # flag line
	$result += $y;
	$result_string .= "$operator 1 x $y";
    } else {   # $x is even, don't add y
	$result_string.="$operator 0 x $y";
    }
    say "\tx=$x\ty=$y";
    $operator=" + ";
    $x>>=1;  # Divde $x by 2
    $y<<=1;  # Multiply $y by 2
}
say " $result_string = $result (Expected: $expected_result)";
