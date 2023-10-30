--
-- Perl Weekly Challenge 235
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
--

CREATE SCHEMA IF NOT EXISTS pwc235;

CREATE OR REPLACE FUNCTION
pwc235.task1_plperl( int[] )
RETURNS boolean
AS $CODE$
   my ( $nums ) = @_;

   for ( 0 .. $nums->@* - 1 ) {
       my @current;
       push @current, $nums->@[ 0 .. $_ - 1 ] if ( $_ != 0 );
       push @current, $nums->@[ $_ + 1 .. $nums->@* - 1 ];

       return 1 if ( join( ',', @current ) eq join( ',', sort @current ) );
   }

   return 0;
$CODE$
LANGUAGE plperl;
