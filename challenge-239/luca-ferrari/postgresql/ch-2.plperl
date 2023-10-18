--
-- Perl Weekly Challenge 239
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-239/>
--

CREATE SCHEMA IF NOT EXISTS pwc239;

/*
testdb=> select pwc239.task2_plperl( 'abc', array['bacca', 'vacca', 'cabaca' ] );
 task2_plperl 
--------------
 bacca
 cabaca
(2 rows)

*/
CREATE OR REPLACE FUNCTION
pwc239.task2_plperl( text, text[] )
RETURNS SETOF text
AS $CODE$
   my ( $allowed, $words ) = @_;

   for my $word ( $words->@* ) {
       my $found = 1;
       for my $char ( split( //, $word ) ) {
       	   $found = 0 and last if ( ! grep( { $_ eq $char } split( //, $allowed ) ) );
       }

       return_next( $word ) if ( $found );
   }

return undef;

$CODE$
LANGUAGE plperl;
