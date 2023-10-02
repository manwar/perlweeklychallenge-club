--
-- Perl Weekly Challenge 226
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-226/>
--

CREATE SCHEMA IF NOT EXISTS pwc226;

CREATE OR REPLACE FUNCTION
pwc226.task1_plperl( text, int[] )
RETURNS text
AS $CODE$
   my ( $string, $indexes ) = @_;
   my ( $index ) = 0;
   my $letters = {};

   for  ( split( //, $string ) ) {
       $letters->{ $indexes->[ $index++ ] } = $_;
   }

   my @chars;
   push @chars, $letters->{ $_ }  for ( sort( $indexes->@* ) );
   return join( '', @chars );

$CODE$
LANGUAGE plperl;
