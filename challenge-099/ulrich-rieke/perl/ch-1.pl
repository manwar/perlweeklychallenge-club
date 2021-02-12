#!/usr/bin/perl ;
use strict ;
use warnings ;
use List::Util qw ( none ) ;
use feature 'say' ;

my $S = $ARGV[ 0 ] ;
my $P = $ARGV[ 1 ] ;
my $len = length $S ;
if ( (length $P ) > $len ) {
      die "The second term should be shorter than the first one!" ;
}
$P =~ s/\*/\.\*/g ;#we have to convert the shell-like regex to a Perl expression
$P =~ s/\?/\./g ;  #same
my @substrings ;#we create substrings by cutting away characters from start a. end
for my $i ( 1 .. $len - 1 ) {
      push @substrings, substr( $S , 0 , $i ) ;
}
for my $pos ( 1 .. $len - 1 ) {
      push @substrings, substr( $S , $pos , $len - $pos ) ;
}
if (( $S =~ m/$P/ ) and (none { $_ =~ m/$P/ } @substrings) ) {
      say 1 ;
}
else {
      say 0 ;
}
