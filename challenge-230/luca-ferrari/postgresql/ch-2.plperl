--
-- Perl Weekly Challenge 230
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-230/>
--

CREATE SCHEMA IF NOT EXISTS pwc230;

CREATE OR REPLACE FUNCTION
pwc230.task2_plperl( text, text[] )
RETURNS int
AS $CODE$
   my ( $prefix, $words ) = @_;
   my $count = 0;

   for ( $words->@* ) {
       $count++ if ( $_ =~ / ^ $prefix /x );
   }

   return $count;
   
$CODE$
LANGUAGE plperl;
