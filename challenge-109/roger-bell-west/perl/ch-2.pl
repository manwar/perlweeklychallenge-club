#! /usr/bin/perl

use strict;
use warnings;

use Algorithm::Permute;

use Test::More tests => 3;

{
  my @q=@{foursquare(1..7)};
  is($q[0],$q[2]+$q[3],'test 1');
  is($q[1]+$q[2],$q[4]+$q[5],'test 2');
  is($q[3]+$q[4],$q[6],'test 3');
}

sub foursquare {
  my @in=@_;
  my @sol;
  Algorithm::Permute::permute {
    my $b=$in[1]+$in[2]+$in[3];
    if ($in[0]+$in[1]==$b) {
      my $c=$in[3]+$in[4]+$in[5];
      if ($b==$c && $c == $in[5]+$in[6]) {
        @sol=@in;
      }
    }
  } @in;
  return \@sol;
}

