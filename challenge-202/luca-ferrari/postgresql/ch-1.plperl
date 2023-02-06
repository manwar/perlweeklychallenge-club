--
-- Perl Weekly Challenge 202
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-202/>
--

CREATE SCHEMA IF NOT EXISTS pwc202;

CREATE OR REPLACE FUNCTION
pwc202.task1_plperl( int[] )
RETURNS int
AS $CODE$
  my ( $list ) = @_;
  my @odds;

  for ( $list->@* ) {
    next if $_ % 2 == 0;

    push( @odds, $_ ) and next if ! @odds;
    next if $_ != ( $odds[ -1 ] + 2 );
    push( @odds, $_ );
  }

  return 1 if @odds >= 3;
  return 0;

$CODE$
LANGUAGE plperl;
