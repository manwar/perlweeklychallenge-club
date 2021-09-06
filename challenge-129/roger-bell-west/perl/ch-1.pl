#! /usr/bin/perl

use strict;

use Test::More tests => 7;
use List::Util qw(max);

is(rd([
               1,
           2,      3,
         0,  0,  0,  4,
        0,0,0,0,0,0,5,6
          ],6),3,'example 1a');
is(rd([
               1,
           2,      3,
         0,  0,  0,  4,
        0,0,0,0,0,0,5,6
          ],5),3,'example 1b');
is(rd([
               1,
           2,      3,
         0,  0,  0,  4,
        0,0,0,0,0,0,5,6
          ],2),1,'example 1c');
is(rd([
               1,
           2,      3,
         0,  0,  0,  4,
        0,0,0,0,0,0,5,6
          ],4),2,'example 1d');
is(rd([
                       1,
               2,              3,
           4,      0,      0,      5,
         0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],7),3,'example 2a');
is(rd([
                       1,
               2,              3,
           4,      0,      0,      5,
         0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],8),4,'example 2b');
is(rd([
                       1,
               2,              3,
           4,      0,      0,      5,
         0,  6,  0,  0,  0,  0,  7,  0,
        0,0,8,9,0,0,0,0,0,0,0,0,0,0,0,0
          ],6),3,'example 2c');

sub rd {
  my ($tree,$content)=@_;
  my $depth=0;
  my $dl=1;
  my $db=1;
  foreach my $i (0..$#{$tree}) {
    if ($tree->[$i] == $content) {
      return $depth;
    }
    $dl--;
    if ($dl==0) {
      $db*=2;
      $dl=$db;
      $depth++;
    }
  }
  return -1;
}
