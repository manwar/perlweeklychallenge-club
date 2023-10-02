--
-- Perl Weekly Challenge 233
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
--

CREATE SCHEMA IF NOT EXISTS pwc233;

CREATE OR REPLACE FUNCTION
pwc233.task1_plperl( text[] )
RETURNS SETOF text
AS $CODE$
   my ( $words ) = @_;

   my $similars = {};

   for my $word ( $words->@* ) {
       my $key = join '', sort split //, $word;
       push $similars->{ $key }->@*, $word;
   }

   for my $key ( keys $similars->%* ) {
       next if $similars->{ $key }->@* <= 1;
       return_next( $_ ) for ( $similars->{ $key }->@* );
   }

return undef;

$CODE$
LANGUAGE plperl;
