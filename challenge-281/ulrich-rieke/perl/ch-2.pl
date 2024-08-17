#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

#find the target fields of the given knight field! Keep doing so for every target
#field until the target field we look for is in the array!

#find possible target fields out of all chess fields possible!
sub findTargetFields {
   my $field = shift ;
   my $chessfields = shift ;
   my $cols = "abcdefgh" ;
   my $rows = "12345678" ;
   my @targetFields = grep { (abs( index( $cols , substr( $field , 0 , 1 )) - 
	 index( $cols , substr( $_ , 0 , 1 ) ) ) == 1 && ( abs( index( $rows , 
	       substr( $field , 1 , 1 ) ) - index( $rows , substr( $_ , 1 , 1 ) )) 
	 == 2 )) || ( abs( index( $cols , substr( $field , 0 , 1 ) ) - index( $cols , 
		  substr($_ , 0 , 1 ))) == 2 && ( abs( index( $rows , substr( 
			$field , 1 , 1 ) ) - index( $rows , substr( $_ , 1 , 1 ) )) 
	       == 1 )) } @$chessfields ;
   return @targetFields ;
}

say "Enter a start and a target field of a knight!" ;
my $line = <STDIN> ;
chomp $line ;
(my $start , my $target ) = split( /\s+/ , $line ) ;
#create all possible chess fields ;
my $cols = "abcdefgh" ;
my $rows = "12345678" ;
my @chessfields ;
for my $col( split( // , $cols ) ) {
   for my $row ( split( // , $rows ) ) {
      push( @chessfields , $col . $row ) ;
   }
}
my %targetsFound ;
my $count = 1 ;
my @targetFields = findTargetFields( $start , \@chessfields ) ;
map { $targetsFound{$_}++ } @targetFields ;
while ( not ( exists( $targetsFound{ $target } ) ) ) {
   $count++ ;
   my @newTargets ;
   for my $field ( keys %targetsFound ) {
      my @currentTargets = findTargetFields( $field , \@chessfields ) ;
      for my $el ( @currentTargets ) {
	 push( @newTargets , $el ) ;
      }
   }
   map { $targetsFound{ $_}++ } @newTargets ;
   @newTargets = ( ) ;
}
say $count ;
