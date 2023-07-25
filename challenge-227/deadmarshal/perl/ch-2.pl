#!/usr/bin/env perl
use strict;
use warnings;
use Roman;

sub roman_maths
{
  my ($n1,$n2,$r) = (arabic($_[0]),arabic($_[2]));
  eval "\$r = $n1 $_[1] $n2;";
  die "Error: $@" if $@;
  if($r != int($r) || $r < 0 || $r > 3999){return "non potest"}
  elsif($r == 0){return "nulla"}
  uc(roman($r));
}

printf "%s\n", roman_maths('IV','+','V');
printf "%s\n", roman_maths('M','-','I');
printf "%s\n", roman_maths('X','/','II');
printf "%s\n", roman_maths('XI','*','VI');
printf "%s\n", roman_maths('VII','**','III');
printf "%s\n", roman_maths('V','-','V');
printf "%s\n", roman_maths('V','/','II');
printf "%s\n", roman_maths('MMM','+','M');
printf "%s\n", roman_maths('V','-','X');

