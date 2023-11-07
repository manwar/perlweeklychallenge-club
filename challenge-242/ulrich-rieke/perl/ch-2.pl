#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub myFlip {
   my $number = shift ;
   if ( $number == 0 ) {
      return 1 ;
   }
   else {
      return 0 ;
   }
}

say "Enter some 0 or 1 , separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @numbers = split( /\s/ , $line ) ;
my $len = scalar( @numbers ) ;
my $counter = 0 ;
my @result ;
while ( $counter < $len - 1 ) {
   my @reversed = reverse ( split( /\s/ , $line ) ) ;
   my @flipped = map {myFlip( $_ )}  @reversed ;
   push @result , join( ',' , @flipped ) ;
   say "Enter $len numbers 0 or 1 , separated by blanks!" ;
   $line = <STDIN> ;
   chomp $line ;
   $counter++ ;
}
my @reversed = reverse ( split( /\s/ , $line ) ) ;
my @flipped = map {myFlip( $_ )}  @reversed ;
push @result , join( ',' , @flipped ) ;
print "(" ;
for my $r( @result ) {
   print "(" . $r . ")" . " " ;
}
say ")"

