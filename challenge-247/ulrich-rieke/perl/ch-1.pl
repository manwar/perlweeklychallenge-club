#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( any ) ;
use POSIX ;

my $rigid = 1 ; #only different second names are accepted
say "Enter some names of possible recipients, separated by , !" ;
my $line = <STDIN> ;
chomp $line ;
my @receivers_old = split( /,/ , $line ) ;
my @receivers ;
for ( @receivers = @receivers_old ) {
   s/\A(\s*)(.+)(\s*)\z/$2/ ;
}
say join( ',' , @receivers ) ;
my @givers = @receivers ;
my @surnames ;
for my $name( @receivers ) {
   if ( $name =~ /(.+)(\s+)(.+)/ ) {
      push @surnames , $3 ;
   }
}
my %frequencies ;
for my $name ( @surnames ) {
   $frequencies{ $name }++ ;
}
if ( any { $frequencies{ $_ } >= floor( scalar( @receivers ) / 2 ) } keys
      %frequencies ) {
#one name is so frequent we must drop the second name requirement
   $rigid = 0 ;
}
my %christmas_pairs ;
my $len = scalar( @receivers ) ;
while ( $len > 0 ) {
   my $giver_index = int( rand( $len ) ) ;
   my $receiver_index = int( rand( $len ) ) ;
   my $giver ;
   my $receiver ;
   if ( $rigid ) { #different second names!
      $giver = $givers[ $giver_index] ;
      $receiver = $receivers[ $receiver_index ] ;
      my $giver_family = (split( /\s+/ , $giver ))[-1] ;
      my $receiver_family = (split( /\s+/ , $receiver ))[-1] ;
      while ( $giver_family eq $receiver_family ) {
	 $giver_index = int( rand( $len ) ) ;
	 $receiver_index = int( rand( $len ) ) ;
	 $giver = $givers[ $giver_index ] ;
	 $receiver = $receivers[ $receiver_index ] ;
	 $giver_family = (split( /\s+/ , $giver ))[-1] ;
         $receiver_family = (split( /\s+/ , $receiver ))[-1] ;
      }
   }
   else {
      $giver = $givers[ $giver_index ] ;
      $receiver = $receivers[ $receiver_index ] ;
      while ( $giver eq $receiver ) {
	 $giver_index = int( rand( $len ) ) ;
	 $receiver_index = int( rand( $len ) ) ;
	 $giver = $givers[ $giver_index ] ;
	 $receiver = $receivers[ $receiver_index ] ;
      }
   }
   $christmas_pairs{ $giver } = $receiver ;
   splice( @givers , $giver_index , 1 ) ;
   splice( @receivers , $receiver_index , 1 ) ;
   $len-- ;
}
for my $donor ( keys %christmas_pairs ) {
   say "$donor => $christmas_pairs{ $donor }" ;
}
