#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( zip min ) ;

say "Enter a word in non-capital English letters!" ;
my $word = <STDIN> ;
chomp $word ;
#tag all letters a to z with numbers 1 to 26!
my %lettertags ;
my @tagged = zip ['a'..'z'] , [1..26] ;
for my $p ( @tagged ) {
   $lettertags{$p->[0]} = $p->[1] ;
}
my $seconds = 0 ;
#if $word doesn't start with a we look for the minimum distance to a
#afterwards , we compute the differences in both clockwise and 
#counterclockwise directions and determine the minimum.
#this minimum difference is added to the number of seconds, afterwards
#the length of the word is added
unless ( substr( $word , 0 , 1 ) eq "a" ) {
   my $number = $lettertags{ substr( $word , 0 , 1 ) } ;
   my $onedir_diff = abs($number - 1 ) ;
   my $otherdir_diff = 26 - $onedir_diff ;
   my $diff = min( $onedir_diff , $otherdir_diff ) ;
   $seconds += $diff ;
}
my $len = length( $word ) ;
for my $pos( 0..$len - 2 ) {
   my $firstchar = substr( $word , $pos , 1 ) ;
   my $secondchar = substr( $word , $pos + 1 , 1 )  ;
   my $firstNum = $lettertags{ $firstchar } ;
   my $secondNum = $lettertags{ $secondchar } ;
   my $onedir_diff = abs( $firstNum - $secondNum ) ;
   my $otherdir_diff = 26 - $onedir_diff ;
   my $diff = min( $onedir_diff , $otherdir_diff ) ;
   $seconds += $diff ;
}
$seconds += $len ;
say $seconds ;
