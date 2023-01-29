--
-- Perl Weekly Challenge 201
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
--

CREATE SCHEMA IF NOT EXISTS pwc201;

CREATE OR REPLACE FUNCTION
pwc201.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $n ) = @_;

   for my $needle ( 1 .. $n->@* ) {
       return_next( $needle ) if ( ! grep( { $_ == $needle } $n->@* ) );
   }

return;
$CODE$
LANGUAGE plperl;
