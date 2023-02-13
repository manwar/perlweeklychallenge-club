--
-- Perl Weekly Challenge 203
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-203/>
--

CREATE SCHEMA IF NOT EXISTS pwc203;

CREATE OR REPLACE FUNCTION
pwc203.task1_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = @_;
  my @quadruplets;

  for my $a ( 0 .. scalar( $list->@* ) - 1  ) {
    for my $b ( $a + 1 .. scalar( $list->@* ) - 1 ) {
      for my $c ( $b + 1 .. scalar( $list->@* ) - 1 ) {
        for my $d ( $c + 1 .. scalar(  $list->@* ) - 1 ) {
	  my ( $la, $lb, $lc, $ld ) = ( $list->[ $a ], $list->[ $b ], $list->[ $c ], $list->[ $d ] );
	  push @quadruplets, [ $la, $lb, $lc, $ld ] if ( ( $la + $lb + $lc ) == $ld );
        }
      }
    }
    
  }

  return scalar @quadruplets;
$CODE$
LANGUAGE plperl;
