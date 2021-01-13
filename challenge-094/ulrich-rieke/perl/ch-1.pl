#!/usr/bin/perl ;
use strict ;
use warnings ;

print "Enter terms!\n" ;
my $S = <STDIN> ;
chomp $S ;
my @S = split ( /\,\s/ , $S ) ;
my %anagrams ;
if ( scalar @S == 1 ) {
  print "[( " . $S[0] . " )]\n" ;
}
else {
  while ( @S ) {
      my $word = shift @S ;
      my $reordered = join( '',  sort ( split (//, $word))) ;
      print "$reordered\n" ;
      push @{$anagrams{ $reordered }}, $word ;
  }
  print "[\n" ;
  for my $value ( values %anagrams ) {
      print '(' . join( ', ' , @$value) . ")\n" ;
  }
  print "]\n" ;
}
