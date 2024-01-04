--
-- Perl Weekly Challenge 250
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-250/>
--

CREATE SCHEMA IF NOT EXISTS pwc250;

CREATE OR REPLACE FUNCTION
pwc250.task2_plperl( text[] )
RETURNS int
AS $CODE$
   my ( $words ) = @_;
   my $max = 0;

   for ( $words->@* ) {
       my $value = 0;

       if ( $_ =~ / ^ \d+ $ /x ) {
       	  $value = int( $_ );
       }
       else {
       	  $value = length( $_ );
       }

       $max = $value if ( $value > $max );
      
   }

   return $max;
$CODE$
LANGUAGE plperl;
