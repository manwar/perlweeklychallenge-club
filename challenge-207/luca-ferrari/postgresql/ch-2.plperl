--
-- Perl Weekly Challenge 207
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-207/>
--

CREATE SCHEMA IF NOT EXISTS pwc207;

CREATE OR REPLACE FUNCTION
pwc207.task2_plperl( int[] )
RETURNS int
AS $CODE$
   
   my ( $citations ) = @_;
   my @cits = reverse sort $citations->@*;
   my @data;
   while ( my ( $key, $value ) = each( @cits ) ) {
   	 push @data, $key if ( $key >= $value );
   }

   return ( sort( @data ) )[ 0 ];
$CODE$
LANGUAGE plperl;
