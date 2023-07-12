--
-- Perl Weekly Challenge 225
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
--

CREATE SCHEMA IF NOT EXISTS pwc225;

CREATE OR REPLACE FUNCTION
pwc225.task1_plperl( text[] )
RETURNS int
AS $CODE$
   my ( $sentences ) = @_;

   my $max = 0;

   for ( $sentences->@* ) {
       my $count = scalar split( /\s/, $_ );
       $max = $max > $count ? $max : $count;
   }

   return $max;
$CODE$
LANGUAGE plperl;
