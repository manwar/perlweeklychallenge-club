#!/usr/bin/env perl
use strict; 
use warnings;
use v5.10;
use constant {
ACTUALYEAR => 2019,
ACTUALDAY => 3,
ACTUALORDER => 3,
};
my $year = ACTUALYEAR;
my $order = ACTUALORDER;
my $day = ACTUALDAY;
  for ( $year .. 2099 ) {
    if ( $day == 7 ) {
      if ( $order != 4) {
      print "25 December of $year - Sunday \n";
}
}
    $year++;
    if ( $order == 4 ) {
      $order = 1;
      $day += 2;
}
    else { 
      $day += 1;
      $order++;
}
    $day = 1 if $day == 8;
    $day = 2 if $day == 9;
}
print "25 December of 2100 - Sunday \n"; 
END