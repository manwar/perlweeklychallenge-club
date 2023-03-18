--
-- Perl Weekly Challenge 208
-- Task 1
-- See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-208/>
--

CREATE SCHEMA IF NOT EXISTS pwc208;

/**
  testdb=> select pwc208.task1_plperl( array['Perl', 'Raku', 'PHP']::text[], array['Raku', 'Perl', 'Java']::text[] );
 task1_plperl 
--------------
 Perl
 Raku
(2 rows)

*/
CREATE OR REPLACE FUNCTION
pwc208.task1_plperl( text[], text[] )
RETURNS SETOF text
AS $CODE$
  my ( $first, $second ) = @_;
  my %results;

  for my $a ( 0 .. $first->@* ) {
      next if ! grep( $first->[ $a ], $second->@* );
      
      my $b = ( grep( $first->[ $a ] eq $second->[ $_ ], 0 .. $second->@* ) )[ 0 ];
      push $results{ $a + $b }->@*, $first->[ $a ];
  }

  my $min = ( sort keys %results )[ 0 ];
  return_next( $_ ) for ( $results{ $min }->@* );

return undef;

$CODE$
LANGUAGE plperl;
