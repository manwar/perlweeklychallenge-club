#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw( max ) ;

sub letter_frequency {
   my $word = shift ;
   my %frequency ;
   for my $letter( split( // , $word ) ) {
      $frequency{$letter}++ ;
   }
   return %frequency ;
}

sub all_substrings {
   my $word = shift ;
   my $k = shift ;
   my $l = length( $word ) ;
   my @substrings ;
   for my $start( 0..$l - 1 - $k) {
      for my $howmany( $k..$l - $start) {
         push( @substrings , substr( $word , $start , $howmany ) ) ;
      }
   }
   return @substrings ;
}

sub analyze_freq {
   my $frequencies = shift ;
   my $maxfreq = max( values( %{$frequencies} )) ;
   my @retvalues;
   my $total = 0 ;
   for my $key( keys( %{$frequencies} ) ) {
      if ( $frequencies->{$key} != $maxfreq ) {
         $total += $frequencies->{$key} ;
      }
   }
   push( @retvalues, $maxfreq ) ;
   push( @retvalues , $total ) ;
   return @retvalues ;
}

say "Enter a word with capital letters and a number k!" ;
my $line = <STDIN> ;
chomp $line ;
my ( $word , $k ) = split( /\s/ , $line ) ;
my $l = length( $word ) ;
my %freqs = letter_frequency( $word ) ;
if ( $l == scalar( keys( %freqs ) )) { #all letters are different 
      say ( $k + 1 ) ;
}
elsif ( scalar( keys( %freqs ) ) == 1 ) { #all letters are the same!
   say $l ;
}
else {
   my @all_substrings = all_substrings( $word , $k ) ;
   my @all_frequencies ;
   for my $s( @all_substrings ) {
      my %f = letter_frequency( $s ) ;
      push( @all_frequencies , \%f ) ;
   }
   my @all_pairs ;
   for my $f( @all_frequencies ) {
      my @pair = analyze_freq( $f ) ;
      push( @all_pairs , \@pair ) ;
   }
   my @selected = grep { $_->[1] == $k } @all_pairs ;
   my @sorted = sort { ($b->[0] + $b->[1]) <=> ($a->[0] + $a->[1]) } @selected ;
   say ($sorted[0]->[0] + $sorted[0]->[1]) ;
}
