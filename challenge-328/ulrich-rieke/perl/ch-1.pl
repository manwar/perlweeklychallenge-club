#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a word with lower case English characters and one ?!" ;
my $word = <STDIN> ;
chomp $word ;
my @characters = ('a'..'z') ;
my %found ;
if ( $word =~ /(.)\?(.)/ ) {
   $found{$1}++ ;
   $found{$2}++ ;
}
my @difference = grep { not exists( $found{$_} ) } @characters ;
my $replacement = $difference[0] ;
$word =~ s/\?/$replacement/ ;
say $word ;
