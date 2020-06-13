#!/usr/bin/perl ;
use strict ;
use warnings ;

my $S = $ARGV[0] ;
my @W = ( "weekly" , "challenge" , "perl" ) ;
my @found ;
for my $word ( @W ) {
  if ( $S =~ /$word/ ) {
      push( @found , $word ) ;
  }
}
if ( @found ) {
  print join( ',' , @found ) ;
  print "\n" ;
}
else {
  print "0 as none matching word found.\n" ;
}
