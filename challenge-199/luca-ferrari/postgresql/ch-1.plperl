-- Perl Weekly Challenge 199
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc199;

CREATE OR REPLACE FUNCTION
pwc199.task1_plperl( int[] )
RETURNS int
AS $CODE$

  my ( $list ) = @_;
  my @pairs;

  for my $i ( 0 .. $list->@* ) {
   for my $j ( $i .. $list->@* ) {
     next if $i == $j;
     push @pairs, [ $i, $j ] if ( $list->[ $i ] == $list->[ $j ] );
   }
 }

 return scalar @pairs;

$CODE$
LANGUAGE plperl;
