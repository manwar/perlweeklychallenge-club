#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter some integers, separated by blanks!" ;
my $line = <STDIN> ;
chomp $line ;
my @firstNumbers = split( /\s+/ , $line ) ;
say "Enter some unique integers that are a subset of the first ones!" ;
$line = <STDIN> ;
chomp $line ;
my @secondNumbers = split( /\s+/ , $line ) ;
my @result ; #final result array
my %firstFrequencies ; #frequencies of numbers in the first list
my %secondFrequencies ; #frequencies of numbers in the second list , for 
#the determination of list difference
map { $firstFrequencies{$_}++ } @firstNumbers ;
map { $secondFrequencies{$_}++ } @secondNumbers ;
for my $n ( @secondNumbers ) {
   for my $i ( 1..$firstFrequencies{ $n } ) {
      push( @result , $n ) ;
   }
}
my @diffList = grep { not ( exists( $secondFrequencies{$_} ) ) } keys
 %firstFrequencies ; #list of numbers in first list but not in second
my @sorted = sort @diffList ;
for my $num ( @sorted ) {
   for my $i ( 1..$firstFrequencies{$num} ) {
      push( @result , $num ) ;
   }
}
say join( ',' , @result ) ;
