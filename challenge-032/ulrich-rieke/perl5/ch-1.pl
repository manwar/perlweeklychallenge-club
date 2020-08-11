#!/usr/bin/perl ;
use strict ;
use warnings ;

sub printStrings {
  my @strings = @_ ;
  my %stringhash ;
  my $maxlen = 0 ;
  for my $str ( @strings ) {
      $stringhash{ $str }++ ;
      if ( length $str > $maxlen ) {
    $maxlen = length $str ;
      }
  }
  my @ordered = sort { $stringhash{ $b } <=> $stringhash{ $a } } keys
      %stringhash ;
  print "output as csv ? (y)es or (n)o ?" ;
  my $answer = <STDIN> ;
  chomp $answer ;
  if ( substr( $answer , 0 , 1 ) eq "n" ) {
      for my $str ( @ordered ) {
    print $str ;
    print " " x ( $maxlen - length( $str ) + 1 ) . "$stringhash{ $str }\n" ;
      }
  }
  else {
      for my $str ( @ordered ) {
    print "$str,$stringhash{ $str }\n" ;
      }
  }
}

my @strings ;
my @files ;
foreach my $arg (@ARGV) {
  if ( -e $arg && -f $arg ) {
      push ( @files , $arg ) ;
  }
  else {
      push ( @strings , $arg ) ;
  }
}
if ( @strings ) {
  printStrings( @strings ) ;
}
if ( @files ) {
  foreach my $file ( @files ) {
      open( FH, "< $file" ) or die "Couldn't open file $file !\n" ;
      my @lines = <FH> ;
      close FH ;
      for my $line ( @lines ) {
    chomp $line ;
      }
      print "The content of file $file, ordered by frequency:\n" ;
      printStrings( @lines ) ;
  }
}
