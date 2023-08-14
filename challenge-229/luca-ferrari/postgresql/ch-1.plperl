--
-- Perl Weekly Challenge 229
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-229/>
--

CREATE SCHEMA IF NOT EXISTS pwc229;

CREATE OR REPLACE FUNCTION
pwc229.task1_plperl( text[])
RETURNS int
AS $CODE$
   my ( $words ) = @_;
   my $deleted = 0;

   for my $word ( $words->@* ) {
       my $sorted = join( '', sort( split( //, $word ) ) );
       $deleted++ if ( $word ne $sorted );
   }

   return $deleted;
$CODE$
LANGUAGE plperl;
