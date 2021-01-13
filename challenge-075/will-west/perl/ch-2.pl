#!/usr/bin/perl
use 5.28.1;
use warnings;
use List::Util 'max';
use Data::Dumper;



#TASK #2 › Largest Rectangle Histogram
#Submitted by: Mohammad S Anwar
#
#You are given an array of positive numbers @A.
#
#Write a script to find the largest rectangle histogram created by the given array.


#my solution takes advantage of the fact that a chart like what we're working with never has vertical gaps. So, we just need to find contiguous horizontal lines and square them with the distance from the chart's base.

#I promise to try to do proper testing for the next one!


my @chart = getchart();
my @rows = makerowsfromchart(@chart);
my @contiguous = contiguousinrows(@rows);
my @squares = square(@contiguous);
my $biggestsquare = max(@squares);
say $biggestsquare;





sub getchart{
   (1,4,6,4,2,2,4,5,5)
}







sub makerowsfromchart{
   my $mx = max @_;
   my @rows;
   for my $row (1..$mx){
      for my $col (@_){
         push @{$rows[$row]}, int($col>=$row)
      }
   }
   @rows
}

sub contiguousinrows{
   my @longests;
   for my $row (1..$#_){
      my $str = join '',@{$_[$row]};
      my @contigs = ($str=~/(1+)/g);
      my @lengths =map{length($_)}@contigs;
      push @longests, [$row, max(@lengths)];
   }
   @longests
}


sub square{
   map{ $_->[0] * $_->[1] } @_
}





sub DEPRECATEDsquare{
   my @sqrd;
   push @sqrd, $_->[0] * $_->[1] for @_;
   @sqrd
}
