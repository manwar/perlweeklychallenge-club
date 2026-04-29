#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub find_missing {
   my $letters = shift ;
   my @diffs ; #for the differences in letter values
   my $len = scalar( @$letters ) ;
   for my $pos( 1..$len - 1 ) {
      if ( $letters->[$pos] ne '?' && $letters->[$pos - 1] ne '?' ) {
         push( @diffs , ord( $letters->[$pos] ) - ord( $letters->[$pos - 1] )) ;
      }
   }
   my %uniques ; #how many different differences ;
   map { $uniques{$_}++ } @diffs ;
   my $question_pos ; #where is the question mark ?
   for my $pos( 0..$len - 1) {
      if ( $letters->[$pos] eq '?' ) {
         $question_pos = $pos ;
         last ;
      }
   }
   if (scalar( keys %uniques ) == 1 ) { #only one difference
      if ( $question_pos == 0 ) {
         return chr( ord( $letters->[1])  - $diffs[0] ) ;
      }
      else {
         return chr( ord( $letters->[$question_pos - 1] ) + $diffs[0] ) ;
      }
   }
   else { #alternating sequence 
      my @startdiffs = @diffs[0..1] ;
      for (1..2 ) {
         push( @startdiffs , $diffs[0] ) ;
         push( @startdiffs , $diffs[1] ) ;
      }
      if ( $question_pos == 0 ) {
         return chr( ord( $letters->[1] ) - $startdiffs[0] ) ;
      }
      else {
         return chr( ord( $letters->[$question_pos - 1]) + $startdiffs[
                  $question_pos - 1] ) ;
      }
   }
}
my @example_one = ('a' , 'c' , '?' , 'g' , 'i') ;
say find_missing( \@example_one) ;
my @example_two = ('a' , 'd' , '?' , 'j' , 'm' ) ;
my @example_three = ( 'a' , 'e' , '?' , 'm' , 'q' ) ;
my @example_four = ('a' , 'c' , 'f' , '?' , 'k' ) ;
my @example_five = ( 'b' , 'e' , 'g' , '?' , 'l' ) ;
say find_missing( \@example_two ) ;
say find_missing( \@example_three ) ;
say find_missing( \@example_four ) ;
say find_missing( \@example_five ) ;

