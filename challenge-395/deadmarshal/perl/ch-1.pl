#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub parse_complex{
  my ($s) = @_;
  if ($s =~ /^\s*(-?\d+)\s*\+\s*\(?\s*(-?\d+)\s*\)?\s*i\s*$/){
    return ($1, $2);
  }
  die "Invalid complex number: '$s'\n"
}

sub format_complex{
  my ($re,$im) = @_;
  my $str = $im < 0 ? "($im)" : "$im";
  "$re+${str}i"
}

sub complex_number{
  my ($n1,$n2) = @_;
  my ($a,$b) = parse_complex($n1);
  my ($c,$d) = parse_complex($n2);
  my $real = $a * $c - $b * $d;
  my $imag = $a * $d + $b * $c;
  format_complex($real,$imag)
}

is complex_number('1+1i','1+1i'),'0+2i','Example 1';
is complex_number('1+(-1)i','1+(-1)i'),'0+(-2)i','Example 2';
is complex_number('0+3i','0+4i'),'-12+0i','Example 3';
is complex_number('3+4i','3+(-4)i'),'25+0i','Example 4';
is complex_number('50+(-20)i','-10+30i'),'100+1700i','Example 5';

done_testing();

