#!perl.exe

use strict;
use warnings;
use List::Util qw(min max);
use Statistics::Basic qw(median);
use List::MoreUtils qw(first_index);

# AUTHOR: Robert DiCicco
# DATE: 2022-07-04
# Challenge 172 Five Number Summary ( Perl )

my @arr = (1, 2, 5, 6, 7, 9, 12, 15, 18, 19, 27);
my @lower = ();
my @upper = ();

@arr = sort { $a <=> $b } @arr;

my $med = median(@arr);
my $min = min(@arr);
my $max = max(@arr);

my $med_index = first_index { $_ eq $med } @arr;
my $max_index = first_index { $_ eq $max } @arr;

for(my $x = 0; $x < $med_index; $x++){
   push(@lower, $arr[$x]);
}

for(my $x = $med_index+1; $x <= $max_index; $x++){
   push(@upper, $arr[$x]);
}

my $q1 = median(@lower);
my $q3 = median(@upper);

print("\( ");
foreach(@arr){
  print("$_ ");
}

print("\)\n");

print("min = $min; q1 = $q1; median = $med; q3 = $q3; max = $max\n");
