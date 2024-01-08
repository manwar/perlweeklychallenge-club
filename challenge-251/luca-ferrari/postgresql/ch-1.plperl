--
-- Perl Weekly Challenge 251
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-251/>
--

CREATE SCHEMA IF NOT EXISTS pwc251;

CREATE OR REPLACE FUNCTION
pwc251.task1_plperl( int[] )
RETURNS int
AS $CODE$
   my ( $nums ) = @_;
   my $sum = 0;
   
   for  ( 0 .. $nums->@* - 2 ) {
	next if $_ % 2 != 0;
        $sum += $nums->@[ $_ ] . $nums->@[ $_ + 1 ];
   }

   return $sum;
$CODE$
LANGUAGE plperl;
