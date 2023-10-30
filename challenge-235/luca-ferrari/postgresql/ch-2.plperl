--
-- Perl Weekly Challenge 235
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-235/>
--

CREATE SCHEMA IF NOT EXISTS pwc235;

CREATE OR REPLACE FUNCTION
pwc235.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;
   my $remaining = $nums->@* - 1;

   for ( $nums->@* ) {
      
       return_next( $_ );
       $remaining--;
       return undef if $remaining <= 0;

       return_next( 0 ) if ( $_ == 0 );
       $remaining--;
       return undef if $remaining <= 0;       

   }

return undef;
$CODE$
LANGUAGE plperl;
