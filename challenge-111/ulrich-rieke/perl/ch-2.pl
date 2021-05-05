#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub sortLetters {
  my $word = shift ;
  return join( '', sort { $a cmp $b } split (// , lc $word ) ) ;
}

my $infile = $ARGV[0] ;
open( my $fh, "<" , $infile ) or die "Can't open $infile!" ;
my $unchangedLongest = " " ;
while ( my $line = <$fh> ) {
  chomp $line ;
  if ( $line !~ /^$/ ) {
      if ( (sortLetters( $line ) eq $line) && (length $line > length
    $unchangedLongest)) {
    $unchangedLongest = $line ;
      }
  }
}
close $fh ;
say "The longest English word that doesn't change on sorting is "
. "$unchangedLongest!" ;
