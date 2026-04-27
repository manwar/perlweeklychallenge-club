#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub convert {
   my $word = shift ;
   $word =~ s/[[:punct:]]//g ;
   $word = lc( $word ) ;
   return $word ;
}

sub contains {
   my $word = shift ;
   my $array = shift ;
   for my $w( @$array ) {
      if ( $w eq $word ) {
         return 1 ;
      }
   }
   return 0 ;
}

say "Enter a paragraph!" ;
my $paragraph = <STDIN> ;
chomp $paragraph ;
say "Enter some banned words!" ;
my $line = <STDIN> ;
chomp $line ;
my @banned = split( /\s/ , $line ) ;
my @allWords = split( /\s/ , $paragraph ) ;
if ( scalar( @allWords ) == 1 ) {
   @allWords = split( /[[:punct:]]/ , $paragraph ) ;
}
my @converted = map { convert( $_ ) } @allWords ;
my %frequencies ;
for my $w( @converted ) {
   if ( not contains( $w , \@banned ) ) {
      $frequencies{$w}++ ;
   }
}
my @sorted = sort { $frequencies{$b} <=> $frequencies{$a} } keys 
%frequencies ;
say $sorted[0] ;
