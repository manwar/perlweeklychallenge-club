--
-- Perl Weekly Challenge 231
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-231/>
--

CREATE SCHEMA IF NOT EXISTS pwc231;

CREATE OR REPLACE FUNCTION
pwc231.task2_plperl( text[] )
RETURNS int
AS $CODE$
   my ( $passengers ) = @_;
   my $count = 0;
   
   for ( $passengers->@* ) {
       if ( / ^ \d{10} [MF] (\d{2}) \d{2} $ /x ) {
          $count++ if ( $1 >= 60 );    	  
       }
   }

   return $count;
$CODE$
LANGUAGE plperl;
