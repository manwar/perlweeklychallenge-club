#!/usr/bin/env perl
package Christmas; 

use strict; 
use warnings;
use v5.10;

 my $year = 2019;
 my $i = 3;
 my $x = 2;
 my @day = qw(Monday Tuesday Wednesday Thursday Friday Saturday Sunday);
  for ($year .. 2099 ) {
    print ( "25 December of $year - $day[$x] \n");
    $year++;
     if ($i == 4) {
      $i = 1;
      $x += 2;
}
     else { 
      $x += 1;
      $i++;
}
  if ($x == 7) { $x = 0; }
  if ($x == 8) { $x = 1; }
}
 print ("25 December of 2100 - $day[$x] \n"); 
END