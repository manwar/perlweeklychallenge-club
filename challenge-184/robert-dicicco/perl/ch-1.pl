#!perl.exe

use strict;
use warnings;
use feature qw/say/;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-26
# Challenge 184 Sequence Number ( Perl )

my $cnt = 0;

my @arr = ( 'ab1234', 'cd5678', 'ef1342');

#my @arr = ( 'pq1122', 'rs3334');

print("Input: \@list = (" );

foreach (@arr) {

  print("\'$_\' ");

}

print(")\n");

print("Output: (");

foreach (@arr) {

  my $pt1 = substr($_,0,2);

  my $pt2 = substr($_,2,4);

  my $text1 = sprintf("%.2d", $cnt );

  $cnt++;

  print("$text1$pt2 ");

}

print(")\n");
