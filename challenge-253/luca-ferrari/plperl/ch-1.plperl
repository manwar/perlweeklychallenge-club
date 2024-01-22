--
-- Perl Weekly Challenge 253
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-253>
--

CREATE SCHEMA IF NOT EXISTS pwc253;

CREATE OR REPLACE FUNCTION
pwc253.task1_plperl( char, text[] )
RETURNS SETOF text
AS $CODE$

   my ( $separator, $words ) = @_;
   for my $word ( $words->@* ) {
       my $pattern = qr/ [$separator] /x;
       
       if ( $word !~ $pattern ) {
       	  return_next( $word );
	  next;
       }

       return_next( $_ ) for ( split( /$pattern/, $word ) );
   }

return undef;
$CODE$
LANGUAGE plperl;
