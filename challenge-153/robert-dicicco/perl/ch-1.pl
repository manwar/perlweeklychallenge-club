#!perl.exe

use strict;
use warnings;
use ntheory qw/factorial/;

# Author: Robert DiCicco
# Date:   21-FEB-2022
# Challenge #153 Left Factorials ( Perl )

my $prevval = 0;

print 'Left Factorials: ';

foreach(0..9){
  my $val = factorial($_);

  $prevval += $val;

  print "$prevval ";
}

print "\n";
