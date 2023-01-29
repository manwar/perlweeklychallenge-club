--
-- Perl Weekly Challenge 201
-- Task 2
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-201/>
--

CREATE SCHEMA IF NOT EXISTS pwc201;

CREATE OR REPLACE FUNCTION
pwc201.task2_plperl( int)
RETURNS int
AS $CODE$

  use Integer::Partition;
  my $partitions = Integer::Partition->new( $_[0] );
  my $count = 0;
  $count++  while( $partitions->next );
  return $count;
$CODE$
LANGUAGE plperlu;
