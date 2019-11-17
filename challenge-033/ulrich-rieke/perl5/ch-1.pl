#!/usr/bin/perl ;
use strict ;
use warnings ;

for my $file ( @ARGV ) {
  if ( -e $file && -f $file ) {
      my %lettercount ;
      open ( FH , "< $file" ) ;
      while ( my $line = <FH> ) {
    chomp $line ;
    my @words = split (/\s+/ , $line ) ;
    for my $word ( @words ) {
        my $lowerword = lc $word ;
        $lowerword =~ s/[^a-z]//g ;
        for my $letter ( split (//, $lowerword )) {
          $lettercount{ $letter }++ ;
        }
      }
    }
      my @sorted = sort {$a cmp $b } keys %lettercount ;
      print "letter frequency for file $file:\n" ;
      for my $letter ( @sorted ) {
    print "$letter: $lettercount{ $letter }\n" ;
      }
      close FH ;
    }
    else {
      print "Can't open file $file!\n" ;
  }
}
