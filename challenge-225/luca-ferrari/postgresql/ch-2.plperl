--
-- Perl Weekly Challenge 225
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-225/>
--

CREATE SCHEMA IF NOT EXISTS pwc225;

CREATE OR REPLACE FUNCTION
pwc225.task2_plperl( int[] )
RETURNS SETOF int
AS $CODE$
   my ( $numbers ) = @_;

   my ( @left, @right );

   push @left, 0;
   for my $index ( 0 .. scalar( $numbers->@* ) - 2 ) {
       my $sum = 0;
       $sum += $_ for ( $numbers->@[ 0 .. $index ] );
       push @left, $sum;
   }

   for my $index ( 1 .. scalar( $numbers->@* ) - 1 ) {
       my $sum = 0;
       $sum += $_ for ( $numbers->@[ $index .. scalar( $numbers->@* )  ] );
       push @right, $sum;
   }

   for my $index ( 0 .. $#left ) {
       my $value = $left[ $index ] - $right[ $index ];
       $value = $value > 0 ? $value : $value * - 1;
       return_next( $value );
   }

return undef;


$CODE$
LANGUAGE plperl;
