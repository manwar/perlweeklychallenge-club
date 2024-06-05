#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

say "Enter a valid IPv4 address!" ;
my $address = <STDIN> ;
chomp $address ;
$address =~ s/\./\[\.\]/g ;
say $address ;
