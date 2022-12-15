#!/usr/bin/env perl

=begin pod

AUTHOR: Robert DiCicco

DATE: 2022-12-12

Challenge 195 Special Integers ( Perl )

 

SAMPLE OUTPUT

 

perl .\SpecialIntegers.pl

Input: $n = 15

Output: 14

 

Input: $n = 35

Output: 32

=cut

 

use strict;

use warnings;

use feature qw/say/;

 

sub CheckUniqDigits {

  my $n = shift;

  my %h1 = ();

  my @arr = split("",$n);

  foreach my $val (split("",$n)){

    exists $h1{$val} ? return 0 : $h1{$val}++;

  }

  return 1;

}

 

foreach my $input (15, 35) {

  my $output = 0;

  print "Input: \$n = $input\n";

  for my $n (1..$input) {

    $output += CheckUniqDigits($n);

  }

  print "Output: $output\n\n";

}

 
