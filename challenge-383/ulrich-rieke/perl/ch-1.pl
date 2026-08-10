#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( all ) ;
use Data::Dumper qw ( Dumper ) ;

sub contains {
   my $list = shift ;
   my $word = shift ;
   for my $w( @$list ) {
      if ( $w eq $word ) {
         return 1 ;
      }
   }
   return 0 ;
}

sub canBeTransformed {
   my $firstlist = shift ;
   my $secondlist = shift ;
   my $similaritymap = shift ;
   if (scalar( @$firstlist ) != scalar( @$secondlist )) {
      return 0 ;
   }
   else {
      my $l = scalar( @$firstlist ) ;
      my @selected ;
      for my $i (0..$l - 1) {
         if ( $firstlist->[$i] ne $secondlist->[$i] ) {
            push( @selected , $i ) ;
         }
      }
      if ( not @selected ) {
         return 1 ;
      }
      else {
         if ( all { exists( $similaritymap->{$firstlist->[$_]} ) && 
               contains( $similaritymap->{$firstlist->[$_]} , $secondlist->[$_] )
               } @selected ) {
            return 1 ;
         }
         else {
            return 0 ;
         }
      }
   }
}

say "Enter a first list, words separated by blanks!" ;
my $list = <STDIN> ;
chomp $list ;
my @firstList = split( /\s/ , $list ) ;
say "Enter a second list, words separated by blanks!" ;
$list = <STDIN> ;
chomp $list ;
my @secondList = split( /\s/ , $list ) ;
say "Enter a list of sublists , each separated by blanks!" ;
say "Enter <newline> to end list entry!" ;
$list = <STDIN> ;
chomp $list ;
my @thirdList ;
while ( $list ) {
   push( @thirdList, [split( /\s/ , $list )] ) ;
   $list = <STDIN> ;
   chomp( $list ) ;
}
#two list are similar if they have the same length and all those words 
#which are not equal are similar in the sense of the third list
my %similarities ;
for my $sublist( @thirdList ) {
   my $l = scalar( @$sublist ) ;
   my @tail ;
   for my $i( 1..$l - 1) {
      push( @tail , $sublist->[$i] ) ;
   }
   $similarities{$sublist->[0]} = [@tail] ;
}
if ( canBeTransformed( \@firstList , \@secondList , \%similarities ) || 
      canBeTransformed( \@secondList , \@firstList , \%similarities ) ) {
   say "true" ;
}
else {
   say "false" ;
}
