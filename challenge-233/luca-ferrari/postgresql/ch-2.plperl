--
-- Perl Weekly Challenge 233
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-233/>
--

CREATE SCHEMA IF NOT EXISTS pwc233;

CREATE OR REPLACE FUNCTION
pwc233.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $nums ) = @_;

   my $freqs = {};

   for my $current ( $nums->@* ) {
       my $f = grep { $_ == $current } $nums->@*;
       push $freqs->{ $f }->@*, $current;
   }

   for my $f ( sort keys $freqs->%* ) {
       return_next( $_ ) for ( sort $freqs->{ $f }->@* );
   }
   return undef;

$CODE$
LANGUAGE plperl;
