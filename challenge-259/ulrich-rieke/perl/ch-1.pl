#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use DateTime ;
use List::Util qw ( none ) ;

say "Enter a start date!" ;
my $start = <STDIN> ;
chomp $start ;
while ( $start !~ /(\d{4})-(\d{1,2})\-(\d{1,2})/ ) {
   say "incorrect date format! Re-enter!" ;
   $start = <STDIN> ;
   chomp $start ;
}
(my $year , my $month , my $day) = split( /-/ , $start ) ;
say "Enter a day offset!" ;
my $offset = <STDIN> ;
chomp $offset ;
while ( $offset !~ /^\d+$/ ) {
   say "Only digits are allowed! Re-enter!" ;
   $offset = <STDIN> ;
   chomp $offset ;
}
say "Are there any bank holidays to consider? If so, enter in date format each!";
say "Enter <return> to end!" ;
my @holidays ;
my $free = <STDIN> ;
chomp $free ;
while ( $free ) {
   push @holidays, $free ;
   $free = <STDIN> ;
   chomp $free ;
}
my $dtcurrent = DateTime->new(
      year => $year , 
      month => $month , 
      day => $day ,
      ) ;
while ($offset != 0 ) {
   $dtcurrent->add( days => 1 ) ;
   if ( $dtcurrent->day_of_week < 6 && (none { $dtcurrent->ymd eq $_ } @holidays) ) {
      $offset-- ;
   }
}
say $dtcurrent->ymd ;
