-- Perl Weekly Challenge 187
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc187;

CREATE OR REPLACE FUNCTION
pwc187.task2_plperl()
RETURNS VOID
AS $CODE$
$CODE$
LANGUAGE plperl;
-- Perl Weekly Challenge 187
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc187;

CREATE OR REPLACE FUNCTION
pwc187.task2_plperl( int[] )
RETURNS int[]
AS $CODE$
my ( @n ) = $_[0]->@*;
my @triplets;
my $max = 0;


for my $index_a ( 0 .. $#n ) {
  my $a = $n[ $index_a ];

  for my $index_b ( ( $index_a + 1 ) .. $#n ) {
    my $b = $n[ $index_b ];

    for my $index_c ( ( $index_b + 1 ) .. $#n ) {
      my $c = $n[ $index_c ];

      if ( $max <= $a + $b + $c
	  && ( $a + $b ) > $c
	  && ( $b + $c ) > $a
	  && ( $a + $c ) > $b ) {

	@triplets = ( $a, $b, $c );
	$max = $a + $b + $c;
      }
    }
  }
}


return [@triplets];

$CODE$
LANGUAGE plperl;
