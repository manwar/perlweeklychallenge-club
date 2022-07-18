-- Perl Weekly Challenge 174
-- Task 2

CREATE SCHEMA IF NOT EXISTS pwc174;

CREATE OR REPLACE FUNCTION
pwc174.task2_permutation2rank( int[] )
RETURNS int
AS $CODE$

use List::Permutor;

my $input = shift;
elog( DEBUG, "INPUT " . join( ",", @{ $input } ) );

my @permutations;
my $permutator   = List::Permutor->new( @{ $input } );
while ( my @current = $permutator->next ) {
      push @permutations, join( '', @current );
}

@permutations = sort @permutations;

for ( 0 .. $#permutations ) {
    return $_ if $permutations[ $_ ] == join( '', @{ $input } );
}

return -1;
$CODE$
LANGUAGE plperlu;


CREATE OR REPLACE FUNCTION
pwc174.task2_rank2permutation( int, int[] )
RETURNS int[]
AS $CODE$

use List::Permutor;

my $index = shift;
my $input = shift;
elog( DEBUG, "INPUT " . join( ",", @{ $input } ) );

my @permutations;
my $permutator   = List::Permutor->new( @{ $input } );
while ( my @current = $permutator->next ) {
      push @permutations, join( '-', @current );
}

@permutations = sort @permutations;
return [ split '-', @permutations[ $index ] ];

return undef;
$CODE$
LANGUAGE plperlu;
