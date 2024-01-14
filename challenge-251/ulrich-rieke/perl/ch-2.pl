#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;
use List::Util qw ( min max ) ;

say "Enter m integers on n lines, separated by blanks!" ;
say "Enter <return> to end!" ;
my $lucky = -1 ;
my @matrix ;
my @columns ;
my $line = <STDIN> ;
chomp $line ;
while ( $line ) {
   my @numbers = split( /\s/ , $line ) ;
   push( @matrix , \@numbers ) ;
   $line = <STDIN> ;
   chomp $line ;
}
my $colnumbers = scalar( @{$matrix[0]} ) ;
for my $c (0..$colnumbers - 1 ) {
   my @column ;
   for my $row ( @matrix ) {
      push @column , $row->[ $c ] ;
   }
   push @columns , \@column ;
}
my %rowminima ;
for my $row ( @matrix ) {
   my $mini = min( @$row ) ;
   $rowminima{ $mini }++ ;
}
my %colmaxima ;
for my $col ( @columns ) {
   my $maxi = max( @$col  ) ;
   $colmaxima{ $maxi }++ ;
}
my @intersection = grep { exists( $colmaxima{ $_ } ) } keys %rowminima ;
if ( @intersection ) {
   $lucky = $intersection[ 0 ] ;
}
say $lucky ;



