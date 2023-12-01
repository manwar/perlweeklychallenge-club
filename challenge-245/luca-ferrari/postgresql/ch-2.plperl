--
-- Perl Weekly Challenge 245
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
--

CREATE SCHEMA IF NOT EXISTS pwc245;

CREATE OR REPLACE FUNCTION
pwc245.task2_plperl( int[] )
RETURNS int
AS $CODE$
   use Algorithm::Combinatorics qw/ permutations /;
   my ( $digits ) = @_;

   die "Digits must be between 0 and 9" if ( grep( { $_ > 9 || $_ < 0 } $digits->@* ) );

   my $result = -1;
   for my $k ( 0 .. $digits->@* ) {
     my $permutations = permutations( \ $digits->@*, $k );
     while ( my $iter = $permutations->next ) {
     	   my $value = join('', $iter->@* );
	   next if ( $value % 3 != 0 );
	   $result = $value if ( $value > $result );
     }
   }		

   return $result;

$CODE$
LANGUAGE plperlu;
