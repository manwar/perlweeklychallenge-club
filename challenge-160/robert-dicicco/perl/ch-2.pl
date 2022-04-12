#!perl.exe

use strict;
use warnings;
use Switch;

# AUTHOR: Robert DiCicco
# DATE: 11-APR-2022
# Challenge 160 Equilibrium Index ( Perl )

sub leftsum {                           # get sum of the array to left of the inflection point,
  my $a = shift;                        # this includes the inflection point
  my $i = shift;

  my $sum = 0;
  while($i >= 0 ){
    $sum += @$a[$i];
    $i--;
  }

  return $sum;
}

sub rightsum {                          # get sum of the array to right of the inflection point,
  my $a = shift;                        # this includes the inflection point
  my $i = shift;

  my $sum = 0;
  while($i < scalar(@$a) ){
    $sum += @$a[$i];
    $i++;
  }

  return $sum;
}

 sub balance {
   my $a = shift;                       # the input array

   my $flag = 0;                        # 'found' flag
   my $len = scalar(@$a);
   foreach my $i (1..$len-2){           # step thru possible inflection points
      my $leftval = leftsum($a, $i);    # get the sum of left side of inflection point
      my $rightval = rightsum($a,$i);   # get sum of right side of inflection point
      if ($leftval == $rightval){       # compare sums
        print "Output: $i\n\n";
        $flag++;                        # increment flag if equal
        last;
      }
   }

   unless ( $flag > 0 ) {print "Output: -1 as no Equilibrium Index found.\n\n"} ;
 }


my $x = 3;
my @arr;

while($x){
  switch($x) {                              # try each of the supplied arrays
    case 3 { @arr = (1, 3, 5, 7, 9) }
    case 2 { @arr = (1, 2, 3, 4, 5) }
    case 1 { @arr = (2,4,2) }
    else { die "Error: Unknown case!" }
  }

  print "Input: \@n = \( @arr \)\n";

  balance(\@arr);
  $x--;
}
