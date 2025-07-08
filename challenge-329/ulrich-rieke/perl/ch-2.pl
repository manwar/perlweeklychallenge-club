#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any all ) ;

sub isNice {
   my $word = shift ;
   my @letters = split( // , $word ) ;
   for my $letter( @letters ) {
      if ( $letter =~ /[A-Z]/ ) {
	 if (not ( any{ $_ eq lc( $letter ) } @letters )) {
	    return 0 ;
	 }
      }
      if ( $letter =~ /[a-z]/ ) {
	 if ( not (any { $_ eq uc( $letter ) } @letters )) {
	    return 0 ;
	 }
      }
   }
   return 1 ;
}

say "Enter a word consisting of uppercase and lowercase English letters!" ;
my $word = <STDIN> ;
chomp $word ;
my $len = length $word ;
my @substrings ;
for my $start( 0..$len - 2 ) {
   for my $end( $start + 1 .. $len - 1 ) {
      my $subst = substr( $word , $start , $end - $start + 1 ) ;
      push( @substrings , $subst ) ;
   }
}
my @selected = grep { isNice( $_ ) } @substrings ;
if ( @selected ) {
   my @sorted = sort { length( $b ) <=> length( $a ) } @selected ;
   say $sorted[0] ;
}
else {
   say "\"\"" ;
}
