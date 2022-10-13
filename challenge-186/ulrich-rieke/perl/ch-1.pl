#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::MoreUtils qw ( mesh ) ;

sub zip {
  my $first = shift ;
  my $second = shift ;
  return mesh @$first , @$second ;
}

say "Please enter a sequence of digits and letters, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstArray = split( /\s+/ , $line ) ;
say "Enter another line of digits and letters!" ;
$line = <STDIN> ;
chomp $line ;
my @secondArray = split( /\s+/ , $line ) ;
say join( ',' , zip( \@firstArray , \@secondArray )) ;
