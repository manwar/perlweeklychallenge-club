--
-- Perl Weekly Challenge 205
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-205/>
--

CREATE SCHEMA IF NOT EXISTS pwc205;

CREATE OR REPLACE FUNCTION
pwc205.task2_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = @_;
  my $max = 0;

  for my $left ( 0 .. $list->@* ) {
      for my $right ( $left + 1 .. $list->@* ) {
      	  my $xor = $list->[ $left ] ^ $list->[ $right ];
	  $max = $xor if ( $xor > $max );
      }
  }

  return $max;
$CODE$
LANGUAGE plperl;
