#!/usr/bin/perl
use 5.28.1;
use Data::Dumper;
use warnings;
use List::Util qw/min/;

# Perl Weekly Challange 73 part 1!

# take an array.
# take a window of size N.
# slide the window down the array
   # pick the smallest value in the window each iteration

my %TEST; 

say join ",", &theSmallestValue(fromEachWindow(ofAnArray()));
testify (\%TEST); #just testing

sub theSmallestValue{
   my @smallest;
   push @smallest, min @$_  for @_;
   $TEST{theSmallestValue} = \@smallest;
   @smallest
}
sub fromEachWindow{
   my $window = 3; #change to input if wanted
   my @windows = slideMap(\@_, $window);
   $TEST{fromEachWindow}=\@windows;
   @windows
}
sub ofAnArray{
# asking for input's too tedious, and I don't feel like messing with files.
   my @array = map{int rand 20} 1..10;
   $TEST{ofAnArray}=\@array;
   @array
}

# UTILITIES (things that don't fit into the flow of the program)
sub slideMap{
   my($aref,   #can be anything
      $span    #window size
   )=@_;

   $span = 1 unless $span; 
   my $adjSpan = $span - 1; #beware off by one
   map{[@$aref[$_-$adjSpan..$_]]}$adjSpan..$#$aref
}


sub testify{
#nothing but us tests!
# I mean, if I ever bothered to learn how to use the ACTUAL testing routines . . .

   my $t = pop;
   my %test=%$t;

   for (0..$#{$test{fromEachWindow}}){
      my $set = $test{fromEachWindow}[$_];
      my $smol = $test{theSmallestValue}[$_];
      say "smallest number from @$set is $smol";
   }
   
}
