--
-- Perl Weekly Challenge 216
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-216/>
--

CREATE SCHEMA IF NOT EXISTS pwc216;

CREATE OR REPLACE FUNCTION
pwc216.task1_plperl( text, text[])
RETURNS SETOF text
AS $CODE$
   my ( $registration_code, $strings ) = @_;
   for my $word ( $strings->@* ) {
       my $matches = 0;
       for my $needle ( split( //, $word ) ) {
       	   $matches++ if ( grep( { $needle eq $_ } split( //, $registration_code ) ) );
       }

       return_next( $word ) if ( $matches == length( $word ) );
   }

return undef;

$CODE$
LANGUAGE plperl;
