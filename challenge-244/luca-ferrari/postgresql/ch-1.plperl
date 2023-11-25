--
-- Perl Weekly Challenge 244
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-244/>
--

CREATE SCHEMA IF NOT EXISTS pwc244;

CREATE OR REPLACE FUNCTION
pwc244.task1_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   for my $needle ( $nums->@* ) {
       return_next( scalar( grep( { $_ > $needle } $nums->@* ) ) );
   }

   return undef;
$CODE$
LANGUAGE plperl;
