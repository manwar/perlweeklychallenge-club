#!/usr/bin/perl ;
use strict ;
use warnings ;

sub last_word {
  my $str = shift ;
  my $rgx = shift ;
  my @found = grep { $_ =~ /$rgx/ } reverse split( /\s+/ , $str ) ;
  if ( @found ) {
      return $found[ 0 ] ;
  }
  else {
      return "undef" ;
  }
}

print last_word( '    hello word' , qr/[ea]l/ ) . "\n" ;
print last_word( "Don't match too much, Chet!",  qr/ch.t/i ) . "\n" ;
