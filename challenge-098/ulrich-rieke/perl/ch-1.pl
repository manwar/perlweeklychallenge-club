#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub readN {
  my ( $str , $howmany ) = @_ ;
  my $buf ;
  my $bytes_read = read( FH, $buf , $howmany ) ;
  say $buf ;
}

my $file = $ARGV[ 0 ] ;
open ( FH , "<" , $file ) or die "Can't open $file! $!" ;
readN( $file , 4 ) ;
readN( $file , 4 ) ;
readN( $file , 4 ) ;
close FH ;
