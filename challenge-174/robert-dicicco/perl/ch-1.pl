#!perl.exe

use strict;
use warnings;

# Author: Robert DiCicco
# DATE: 2022-07-18
# Challenge 174 Disarium Numbers ( Perl )

my $inp = 0;
my @arr = ();

sub getPositSum {

  my @a = @_;

  my $sum = 0;

  for (my $i = 0; $i < scalar(@arr); $i++){

    $sum += $arr[$i] ** ($i+1);

  }

  return $sum;

}

$inp = 0;

my $count = 1;

while($count < 20){

  @arr = split(//, $inp);

  my $retval = getPositSum(\@arr);

  if($retval == $inp){

    print("$retval ");

    $count++;

  }

  $inp++;

}

print(" ");
