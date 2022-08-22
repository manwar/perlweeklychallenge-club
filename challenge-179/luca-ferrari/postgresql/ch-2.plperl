-- Perl Weekly Challenge 179
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc179;

CREATE OR REPLACE FUNCTION
pwc179.task2_plperl( int[] )
RETURNS text
AS $CODE$

   my ($n) = shift;
   my @n;

   my @symbols = map {chr($_)} (0x2581..0x2588);

   my ($min, $max) = (-1,-1);

   # compute min and max over the values
   for my $current ( @$n ) {
       $max = $current if ( $current > $max );
       $min = $current if ( $min == -1 || $current < $min );
       push @n, $current;
   }

   my @graph = map { ( $_ - $min ) / ( $max - $min ) * scalar( @$n ) } @$n;
   return join( '', @symbols[ @graph ] );
$CODE$
LANGUAGE plperl;
