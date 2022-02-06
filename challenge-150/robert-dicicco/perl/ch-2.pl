#!perl.exe

use strict;
use warnings;
use ntheory qw/ factor /;
use 5.30.0;

# Author: Robert DiCicco
# Date: 31-JAN-2022
# Challenge 150 Square-Free Integer (Perl)

my @sqfnums = ();

foreach my $num (1..500){
  my @facs = factor($num);
  my $retval = SquareFree (@facs);
  if($retval > 0){
    push(@sqfnums, $num);
  }
}

say "@sqfnums ";

sub SquareFree {
  my %dvals = ();
  foreach my $val (@_){
    if (! exists($dvals{$val})){
      $dvals{$val} = 1;
    } else {
      return -1;
    }
  }

  return 1;
}
