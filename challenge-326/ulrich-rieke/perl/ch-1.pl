#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use Date::Calc qw ( Delta_Days );

say "Enter a date in the form YYYY-MM-DD !" ;
my $line = <STDIN> ;
chomp $line ;
$line =~ s/\-0/\-/g ;
if ( $line =~ /^(\d{4})\-(\d+)\-(\d+)$/ ) {
   my ( $year , $month , $day ) = ( $1 , $2 , $3 ) ;
   my $diff_days = Delta_Days( $year , 1 , 1 , $year , $month , $day) ;
   say $diff_days + 1 ;
}
else {
   say "Data not in the right format!" ;
}
