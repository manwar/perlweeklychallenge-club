#!perl
use strict;
use warnings;

#Task 1
use POSIX;
for my $year (2019..2100) {
  my $date = POSIX::strftime ("%w %Y-%m-%d",
             0, 0, 0,  25,  11, $year-1900);
  print "$date is a Sunday Christmas\n" if $date =~ s/^0 //g;
}
