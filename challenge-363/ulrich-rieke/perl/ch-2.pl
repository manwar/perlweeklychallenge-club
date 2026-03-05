#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use POSIX ;
use List::Util qw ( all ) ;

sub isValidAddress {
   my $address = shift ;
   if ( scalar(@$address) == 4 && all { $_ =~ /^\d+$/ } @$address ) {
      if ( all { $_ >= 0 && $_ <= 255 } @$address ) {
         return 1 ;
      }
   }
   return 0 ;
}

sub to_octet {
   my $number = shift ;
   my $binary = "" ;
   while ( $number != 0 ) {
      if ( $number % 2 == 1 ) {
         $binary .= "1" ;
      }
      else {
         $binary .= "0" ;
      }
      $number = floor( $number / 2 ) ;
   }
   my $reversed = join( '' , reverse split (// , $binary ))  ;
   my $result ;
   $result .= '0' x ( 8 - length( $reversed ) ) ;
   $result .= $reversed ;
   return $result ;
}

say "Enter an IPv4 address!" ;
my $ipv4 = <STDIN> ;
chomp $ipv4 ;
say "Enter a network address in CIDR format!" ;
my $cidr = <STDIN> ;
chomp $cidr ;
my @addressparts = split( /\./ , $ipv4 ) ;
my @networkparts = split( /\// , $cidr ) ;
my @networkfirst = split( /\./ , $networkparts[0] ) ;
my $result = "false" ;
if ( (isValidAddress( \@addressparts )) && (isValidAddress( \@networkfirst ))) {
      my $secondpart = $networkparts[1] ;
      if ( ($secondpart =~ /^\d{1,2}$/) && ($secondpart >= 0) && $secondpart <= 32 ) {
         my $allAddressOctets ;
         my $networkOctets ;
         for my $part( @addressparts ) {
            $allAddressOctets .= to_octet( $part ) ;
         }
         for my $part( @networkfirst ) {
            $networkOctets .= to_octet( $part ) ;
         }
         if ( substr( $allAddressOctets , 0 , $secondpart ) eq substr( $networkOctets , 
                  0 , $secondpart )) {
            $result = "true" ;
         }
      }
}
say $result ;
