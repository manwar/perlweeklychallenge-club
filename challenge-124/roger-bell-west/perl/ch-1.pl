#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my $char='^';
my @shape=(3,-3,-4,-5,-5,-5,-5,-5,-4,-3,3,1,1,1,3,1,1);
my $mx=max(map {abs($_)} @shape);

foreach my $row (@shape) {
  my $line;
  if ($row>0) {
    $line=$char x $row;
  } else {
    $line=(' ' x -$row).$char;
  }
  my $ll=length($line);
  if ($ll <= $mx) {
    $line .= ' ' x ($mx-$ll+1);
  }
  my $f=reverse $line;
  substr($f,-1)='';
  print "$f$line\n";
}
